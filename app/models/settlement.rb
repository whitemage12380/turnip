require 'town'

class Settlement
  include ActiveModel::Model
  attr_accessor :settlement_obj

  def initialize(user_or_obj, type = nil)
    if user_or_obj.kind_of? ::Settlements::Settlement
      obj = user_or_obj
      @settlement_obj = obj
      return
    else
      raise "Settlement type not specified" if type.nil?
      user = user_or_obj
    end
    dir = self.settlements_directory(user)
    FileUtils.mkdir_p(dir)
    settlement_settings = {'save_directory' => dir.to_s}
    @settlement_obj = case type.downcase
    when 'town'
      ::Settlements::Town.new(settlement_settings)
    else
      raise "Settlement type not supported: #{type}"
    end
  end

  def to_h()
    @settlement_obj.to_h
  end

  def self.all_for_user(user)
    dir = self.settlements_directory(user)
    return [] unless  Dir.exist?(dir)
    return Dir.glob("#{dir}/*.yaml").collect { |f| self.load(user, f.to_s) }
  end

  def self.load(user, settlement_filename)
    settlement = ::Settlements::Settlement.load(settlement_filename)
    self.new(settlement)
  end

  def self.settlements_directory(user)
    dir = Rails.configuration.x.turnip.base_content_directory.join(user.id.to_s, 'settlements')
  end
end