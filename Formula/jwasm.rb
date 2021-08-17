class Jwasm < Formula
  desc "Masm-compatible assembler"
  homepage "https://github.com/Baron-von-Riedesel/JWasm"
  url "https://github.com/Baron-von-Riedesel/JWasm/archive/refs/tags/v2.14.tar.gz"
  sha256 "633d94bd8bb8f5915dd3338d69bc8cb48dbcd923e013c6ee1456cd6e13fc3a5a"
  license "Watcom-1.0"

  bottle do
    root_url "https://github.com/btb/homebrew-open-watcom/releases/download/jwasm-2.13"
    sha256 cellar: :any_skip_relocation, catalina:     "4a6c2fb4c486798d3f12132cbe357584da195aff4bbe7c8c73da5a28b0cafd6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af8ea1056e7549bbceda330c421d4ab8902ce3444c3e43eaa83d70b5de3a7db8"
  end

  patch do
    url "https://github.com/btb/JWasm/commit/0f666f8a8f4794b8e7ed1081ddcdc02b83313853.patch?full_index=1"
    sha256 "3e3290d854121e63cc1adb067c30450d1cb917fea5157d732118b419971213ed"
  end

  def install
    system "make", "-f", "GccUnix.mak"

    bin.install "build/GccUnixR/jwasm"
    prefix.install "History.txt", "README.md"
    doc.install "Html/License.html", "Html/Manual.html", "Html/Readme.html"
    pkgshare.install "Samples"
  end

  test do
    system "true"
  end
end
