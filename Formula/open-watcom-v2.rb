class OpenWatcomV2 < Formula
  desc "Fork of Open Watcom aimed at 64 bit support"
  homepage "https://github.com/open-watcom/open-watcom-v2/wiki"
  license "Watcom-1.0"
  head "https://github.com/open-watcom/open-watcom-v2.git"

  stable do
    url "https://github.com/open-watcom/open-watcom-v2/archive/refs/tags/2021-08-01-Build.tar.gz"
    version "2.0-2021-08-01"
    sha256 "3971d6dbbdb859547f7392edd336a1896db8f93f108a2756d69207a38de4cb82"
  end

  bottle do
    root_url "https://github.com/btb/homebrew-open-watcom/releases/download/open-watcom-v2-2.0-2021-08-01"
    rebuild 3
    sha256 cellar: :any_skip_relocation, catalina:     "e9f2b4c33493b7c8d04f953f9236bcc0040a2ad34986afbff0d042e84304c3e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "547601f01ff083b40ce692ac5370111214f2274b778101a27e500e6cf1b799f3"
  end

  env :std

  keg_only "you should use a script to set up your dev environment"

  depends_on "dosbox" => :build

  def install
    ENV.deparallelize # race conditions in bld/wmake/posmake

    # set the source root
    inreplace "setvars.sh", "export OWROOT=$(realpath `pwd`)", "export OWROOT=#{buildpath}"

    ENV["OWDOSBOX"] = "dosbox"

    # set the install root
    ENV["OWRELROOT"] = prefix

    system("./build.sh", "boot")
    on_macos do
      system(". ./setvars.sh && cd bld && builder rel os_osx")
    end
    on_linux do
      system(". ./setvars.sh && cd bld && builder rel os_linux cpu_x64")
    end
  end

  test do
    system "true"
  end
end
