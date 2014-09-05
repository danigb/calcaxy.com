require 'yaml'
require_relative 'models'


module Repo
  def self.load(name)
    @data ||= {}
    @indexed ||= {}
    @data[name] = YAML::load_file(File.join(__dir__, 'data', "#{name.downcase}s.yml"))
    puts "#{name}: #{@data[name].size} loaded."
    @data[name]
  end

  def self.all(name)
    @data[name]
  end

  def self.find(name, id)
    collection = @data[name]
    @indexed[name] ||= Hash[collection.map {|model| [model.id.to_i, model] }]
    @indexed[name][id.to_i]
  end
end

module Calcaxy
  MODELS = ['Meta', 'Attachment', 'Page']
  MIN_YEAR = 1990
  MAX_YEAR = 2008

  def self.booc_years
    years = (MIN_YEAR..MAX_YEAR).to_a.reverse!
    years.delete(2006)
    years
  end

  def self.valid_year?(string)
    year = string.to_i
    year < MIN_YEAR || year > MAX_YEAR
  end

  def self.load
    MODELS.each {|name| Repo.load(name) }
#    Repo.all('Post').sort_by! {|post| "#{post.rev_date}" }.reverse!
#    Repo.all('Selection').sort_by! {|selection| selection.rev_date }
#    Repo.all('Tag').sort_by! {|post| post.position }
    puts "Calcaxy loaded."
  end
end
