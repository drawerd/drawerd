# Drawerd

Drawerd is a gem that allows you to easily generate a diagram based on your application's Active Record models. The diagram gives an overview of how your models are related. Having a diagram that describes your models is perfect documentation for your application.

Drawerd gem is a toolkit for the free online erd service drawerd.com. It use Rails-ERD to generate tables.csv and relations.csv for drawerd.com.

## DrawERD Features

* You can edit the diagram generated by rails-erd online collaboratively.
* Support grouping function, if you want to split microservices, or modularize your application, drawerd can help you more intuitively. 
* Various built-in modes and layouts support.
* SVG ERD can be downloaded or shared to your project management tool. 
* Powerful filtering function, for large projects, drawerd can focus on specific modules through group filtering. 
* Works with non-rails project well.
* Various importing method: rails-erd, sql and manually via Web UI.
* Free for OSS.

and more detail: https://help.drawerd.com/
Full Video: https://www.loom.com/share/e30d06ba299b43bc8b68f369b47f745a

## Preview

**Full Mode**

![](https://gblobscdn.gitbook.com/assets%2F-M4KXP_B-JS37AxVENXr%2F-M4a6EP51_FLk8enrbaN%2F-M4a6OFk5jOzgwlY5IsS%2Fimage.png?alt=media&token=e088afb7-15b3-4e46-9ca3-ee0669809107)

**Simple Mode**

![](https://gblobscdn.gitbook.com/assets%2F-M4KXP_B-JS37AxVENXr%2F-M4a6EP51_FLk8enrbaN%2F-M4a6F_hxgSCjxEyWO5m%2Fimage.png?alt=media&token=f079a6ff-695e-495e-88e5-c7e8f754c3c7)

**Grouping**

![](https://gblobscdn.gitbook.com/assets%2F-M4KXP_B-JS37AxVENXr%2F-M4a28LNnRt57s9R2qIZ%2F-M4a2Ys8Wfx6qotgxzS6%2Fimage.png?alt=media&token=fbcc87bc-a082-49d3-8ae3-0008e0e68833)

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'drawerd'
end
```

And then execute:

    $ bundle

## Usage

```
bundle exec rails db:migrate
```

and then upload tables.csv & relations.csv via Web UI.

![](https://gblobscdn.gitbook.com/assets%2F-M4KXP_B-JS37AxVENXr%2F-M56Qp7AVYLvGyO_egoS%2F-M56R8QvRsFmGapFdcZr%2Fimage.png?alt=media&token=c80fed1a-57b1-42bf-aa2f-797c8739c24c)

more detail: https://help.drawerd.com/importing/importing-postgresql

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
