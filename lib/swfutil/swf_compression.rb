module SWFUtil

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

    def compress(buffer)
      compressor=Zlib::Deflate.new
      data=compressor.deflate(strip_header(buffer),Zlib::FINISH)
      data=buffer[0,8]+data
      data[0]=?C
      data
    end

    def uncompress(bytes)
      decompressor =Zlib::Inflate.new
      swf=decompressor.inflate(strip_header(bytes))
      swf=bytes[0,8]+swf
      swf[0] = ?F
      swf
    end
  end

end
