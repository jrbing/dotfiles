require 'mustache'

class DatamoverBackup < Mustache

  self.template_path = File.expand_path("../templates", File.dirname(__FILE__))

  attr_accessor :name, :record

  def date_time
   Time.now.localtime.strftime("%m/%d/%Y")
  end

end

class DatafixScript < Mustache

  self.template_path = File.expand_path("../templates", File.dirname(__FILE__))

  attr_accessor :name

  def date_time
   Time.now.localtime.strftime("%m/%d/%Y")
  end

end

class SqlplusScript < Mustache

  self.template_path = File.expand_path("../templates", File.dirname(__FILE__))

  attr_accessor :name

end

class ThorScript < Mustache

  self.template_path = File.expand_path("../templates", File.dirname(__FILE__))

  attr_accessor :name

end

class BashScript < Mustache

  self.template_path = File.expand_path("../templates", File.dirname(__FILE__))

  attr_accessor :name

end
