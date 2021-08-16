class Jwasm < Formula
  desc "Free Masm-compatible assembler"
  homepage "https://jwasm.github.io"
  url "https://github.com/JWasm/JWasm/archive/refs/tags/2.13.tar.gz"
  sha256 "82bc14860ec1d0552daeffbd202f83f9bba6a2756056b5e21ef81fabdb8e83a4"
  license "Watcom-1.0"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"

    bin.install "build/jwasm"
    prefix.install "History.txt", "License.txt", "Readme.txt"
    doc.install Dir["Doc/*"]
  end

  test do
    system "true"
  end
end
