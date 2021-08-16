class Jwasm < Formula
  desc "Free Masm-compatible assembler"
  homepage "https://jwasm.github.io"
  url "https://github.com/JWasm/JWasm/archive/refs/tags/2.13.tar.gz"
  sha256 "82bc14860ec1d0552daeffbd202f83f9bba6a2756056b5e21ef81fabdb8e83a4"
  license "Watcom-1.0"

  bottle do
    root_url "https://github.com/btb/homebrew-open-watcom/releases/download/jwasm-2.13"
    sha256 cellar: :any_skip_relocation, catalina:     "4a6c2fb4c486798d3f12132cbe357584da195aff4bbe7c8c73da5a28b0cafd6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af8ea1056e7549bbceda330c421d4ab8902ce3444c3e43eaa83d70b5de3a7db8"
  end

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
