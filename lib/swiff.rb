require 'swiff/header_info'
require 'swiff/compression'
require 'swiff/packed_bits'

class Swiff
  include HeaderInfo
  include Compression

  def initialize(path)
    @path = path
  end

  def bytes
    @file_contents ||= File.read(@path)
  end
end
