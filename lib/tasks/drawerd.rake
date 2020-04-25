# frozen_string_literal: true

load 'rails_erd/tasks.rake'
require 'rails_erd/diagram'
require 'csv'

class TableSchema
  def initialize(table_name)
    if table_name.split('.').size > 1
      @schema, @name = table_name.split('.')
    else
      @schema = 'public'
      @name   = table_name
    end
  end

  attr_reader :name

  attr_reader :schema
end

class DrawerdDiagram < RailsERD::Diagram
  setup do
    @table_csv = CSV.open(Rails.root.join('tables.csv'), 'wb')
    @relation_csv = CSV.open(Rails.root.join('relations.csv'), 'wb')
    @table_csv << %w[table_schema table_name column_name column_type ordinal_position is_nullable primary_key column_comment table_comment]
    @relation_csv << %w[schema table column no relation_table_schema relation_table relation_column constraint_name relation_type]
  end

  each_entity do |entity|
    model         = entity.model
    table_name    = model.table_name
    table_comment = ActiveRecord::Base.connection.table_comment(table_name)
    table_name    = TableSchema.new(table_name).name
    table_schema  = TableSchema.new(table_name).schema

    entity.attributes.each_with_index do |attribute, ordinal_position|
      column = attribute.column
      column_name = column.name
      column_type = column.type
      is_nullable = column.null ? 't' : 'f'
      primary_key = model.primary_key == column.name ? 't' : 'f'
      column_comment = column.comment
      @table_csv << [table_schema, table_name, column_name, column_type, ordinal_position, is_nullable, primary_key, column_comment, table_comment]
    end
  end
  # Invoked once for each relationship
  each_relationship do |relationship|
    source = relationship.source
    des = relationship.destination
    source_model = source.model
    des_model = des.model
    source_table_name = source_model.table_name
    des_table_name = des_model.table_name

    schema = TableSchema.new(source_table_name).schema
    table  = TableSchema.new(source_table_name).name

    relation_table_schema = TableSchema.new(des_table_name).schema
    relation_table = TableSchema.new(des_table_name).name

    # TODO: fix mutual association
    unless relationship.indirect?
      if ass = relationship.associations.find { |x| x.macro == :has_many || x.macro == :has_one }
        column          = ass.association_primary_key
        relation_column = ass.foreign_key
      end

      if relationship.many_to? && !relationship.many_to_many?
        if ass = relationship.associations.find { |x| x.macro == :belongs_to }
          column          = ass.association_primary_key
          relation_column = ass.foreign_key
        end
        schema, table, column, relation_table_schema, relation_table, relation_colunm = relation_table_schema, relation_table, relation_colunm, schema, table, column
      end
    end

    relation_type = if relationship.one_to_one? then 'one'
                    elsif relationship.indirect? && relationship.one_to_many? then 'm2m'
                    elsif relationship.one_to_many?  then 'many'
                    elsif relationship.many_to_many? then 'm2m'
    end

    @relation_csv << [schema, table, column, 1, relation_table_schema, relation_table, relation_column, nil, relation_type]
  end

  # Should save or return the generated diagram
  save do
    @table_csv.close
    @relation_csv.close
  end
end

namespace :drawerd do
  task generate: ['erd:check_dependencies', 'erd:options', 'erd:load_models'] do
    say "Generating CSV for #{ActiveRecord::Base.descendants.length} models..."

    DrawerdDiagram.create

    say "Done! Saved tables.csv to #{Rails.root.join('tables.csv')}."
    say "Done! Saved relations.csv to #{Rails.root.join('relations.csv')}."
  end
end
