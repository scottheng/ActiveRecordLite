require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    # ...
    return @columns_info unless @columns_info.nil?

    @columns_info = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    @columns_info.first.map! do |el|
      el.to_sym
    end

  end

  def self.finalize!
    self.columns.each do |el|
      define_method(el) do
        attributes[el]
      end

      define_method("#{el}=") do |value|
        attributes[el] = value
      end

    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name = self.name.tableize if @table_name.nil?
    @table_name

  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...

  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
