require 'yaml'
require_relative '../lib/calcaxy'

class PrepareData
  def initialize
    YAML::load_documents(File.new(File.join(__dir__, 'data.yml'), 'r')) do |doc|
      table = doc.keys.first
      send("prepare_#{table}", doc[table]['columns'], doc[table]['records'])
    end
  end

  def prepare_attachments(columns, data)
    prepare_model(Attachment, data)
  end

  def prepare_metas(columns, data)
    prepare_model(Meta, data)
  end

  def prepare_pages(columns, data)
    prepare_model(Page, data)
  end

  def prepare_model(clazz, data)
    models = []
    data.each {|row| models << clazz.new(*row) }
    save_table(clazz.to_s, models)
  end

  def save_table(name, data)
    open("lib/data/#{name.downcase}s.yml", 'w') {|f| YAML.dump(data, f)}
    puts "#{name}: #{data.size} saved."
  end
end

PrepareData.new
