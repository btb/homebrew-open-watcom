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
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "0a100d7bcd7cb1c8f8c55bf346abbb00f21e3ee192ffaf0cc906001b61cc627b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56f7d87d889f80d7c26f94f4dbf47393bdafd1fa67729c38abcbf0289a13582e"
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

    system("./buildrel.sh", "rel")
  end

  test do
    system "true"
  end
end
