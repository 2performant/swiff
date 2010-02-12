require 'swiff/header_info'
require 'swiff/compression'
require 'swiff/packed_bits'

class Swiff
  include HeaderInfo
  include Compression

  def initialize(path)
    @path = path
  end
end
