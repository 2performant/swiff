class Swiff

  module Compression

    def read_file(file,to)
      buff = File.open(file,"rb") do |fin|
        fin.read
      end
      raise RuntimeError.new,"The file have already been compressed",caller if is_compressed?(buff[0])
      result = compress(buff)
      File.open(to,"wb") do |fout|
        fout.write(result)
      end
    end

    def compress
      compressor = Zlib::Deflate.new
      data = compressor.deflate(strip_header(decompressed_bytes), Zlib::FINISH)
      data = bytes[0,8] + data
      data[0] = ?C
      data
    end

    def decompress
      decompressor = Zlib::Inflate.new
      swf = decompressor.inflate(strip_header)
      swf = bytes[0,8] + swf
      swf[0] = ?F
      swf
    end

    def read_full_size
      buff = File.open(@path,"rb") do |f|
        f.seek(4,IO::SEEK_CUR)
        f.read 4
      end
      buff.unpack("L")[0]
    end

    def strip_header(buffer = nil)
      buffer ||= bytes
      buffer[8,bytes.size-8]
    end

    def is_compressed?
      bytes[0] == ?C
    end

  end

end
