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
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina:     "cfe9e23bb2ad79cc9051d3a8da3bd6a8df6679231d082362382b1a6bf8ab3753"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b3005dcfaf5af6f551d60b5ea222a6f3f3e42c1d8af7eeeaf785df7c35577f9e"
  end

  env :std

  keg_only "you should use a script to set up your dev environment"

  depends_on "dosbox" => :build

  patch :DATA

  def install
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

__END__
diff --git a/bld/wmake/posmake b/bld/wmake/posmake
index 51c9320..08adda0 100644
--- a/bld/wmake/posmake
+++ b/bld/wmake/posmake
@@ -30,7 +30,7 @@ memory.o: ../c/memory.c
 	$(CC) $(CFLAGS) -c $?
 mexec.o: ../c/mexec.c
 	$(CC) $(CFLAGS) -c $?
-mglob.o: ../c/mglob.c
+mglob.o: ../c/mglob.c isarray.gh
 	$(CC) $(CFLAGS) -c $?
 mhash.o: ../c/mhash.c
 	$(CC) $(CFLAGS) -c $?
@@ -46,9 +46,9 @@ mparse.o: ../c/mparse.c
 	$(CC) $(CFLAGS) -c $?
 mpreproc.o: ../c/mpreproc.c
 	$(CC) $(CFLAGS) -c $?
-mrcmsg.o: ../c/mrcmsg.c
+mrcmsg.o: ../c/mrcmsg.c usage.gh
 	$(CC) $(CFLAGS) -c $?
-msg.o: ../c/msg.c
+msg.o: ../c/msg.c usage.gh
 	$(CC) $(CFLAGS) -c $?
 mstream.o: ../c/mstream.c
 	$(CC) $(CFLAGS) -c $?
