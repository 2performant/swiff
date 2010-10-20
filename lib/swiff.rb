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
    @bytes ||= File.open(@path, 'rb') { |f| f.read }
  end

  def decompressed_bytes
    if is_compressed?
      @decompressed_file_contents ||= decompress
    else 
      @decompressed_file_contents = bytes
    end
  end
end

# String#[] has different semantics in 1.8 and 1.9, this adds the 1.9
# method #getbyte to 1.8.7.
unless ''.respond_to?(:getbyte)
  class String
    alias_method :getbyte, :[]
  end
end