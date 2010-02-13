require 'zlib'
require 'swiff/header_info'
require 'swiff/compression'
require 'swiff/packed_bits'

class Swiff
  include HeaderInfo
  include Compression

  def initialize(path)
    @path = path
    parse_header
  end

  def bytes
    @file_contents ||= File.read(@path)
  end

  def decompressed_bytes
    if is_compressed?
      @decompressed_file_contents ||= self.decompress
    else 
      @decompressed_file_contents = @file_contents
    end
  end
end
