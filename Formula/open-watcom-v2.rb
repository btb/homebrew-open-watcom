class OpenWatcomV2 < Formula
  desc "Fork of Open Watcom aimed at 64 bit support"
  homepage "https://github.com/open-watcom/open-watcom-v2/wiki"
  url "https://github.com/open-watcom/open-watcom-v2/archive/refs/tags/2021-08-01-Build.tar.gz"
  version "2.0-2021-08-01"
  sha256 "3971d6dbbdb859547f7392edd336a1896db8f93f108a2756d69207a38de4cb82"
  license "Watcom-1.0"
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
    system(". ./setvars.sh && cd bld && builder rel os_osx")
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
