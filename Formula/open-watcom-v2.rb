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

    # build headers and libs

    # If necessary, build clibext library (64-bit)
    # system(". ./setvars.sh && cd bld/watcom && builder rel")
    # Start with language and API headers
    system(". ./setvars.sh && cd bld/hdr && builder rel")
    system(". ./setvars.sh && cd bld/os2api && builder rel")
    system(". ./setvars.sh && cd bld/w16api && builder rel")
    system(". ./setvars.sh && cd bld/w32api && builder rel")
    # Continue with runtime libraries.
    system(". ./setvars.sh && cd bld/clib && builder rel")
    system(". ./setvars.sh && cd bld/mathlib && builder rel")
    system(". ./setvars.sh && cd bld/cpplib && builder rel")
    system(". ./setvars.sh && cd bld/rtdll && builder rel")

    system(". ./setvars.sh && cd bld/f77/f77lib && builder rel")
    system(". ./setvars.sh && cd bld/fpuemu && builder rel")
    system(". ./setvars.sh && cd bld/omftools && builder rel")
    system(". ./setvars.sh && cd bld/graphlib && builder rel")
    # Start with DOS4GW DOS extender stub.
    system(". ./setvars.sh && cd bld/wstuba && builder rel")
    # Continue with Causeway DOS extender.
    # system(". ./setvars.sh && cd bld/causeway && builder rel")
    # Continue with WIN386 extender.
    # system(". ./setvars.sh && cd bld/win386 && builder rel")
    # Now we have enough to start cross building everything else
    # Start with the libs used by various tools
    # system(". ./setvars.sh && cd bld/wres && builder rel")
    # system(". ./setvars.sh && cd bld/orl && builder rel")
    # system(". ./setvars.sh && cd bld/owl && builder rel")
    system(". ./setvars.sh && cd bld/dwarf && builder rel")
    # system(". ./setvars.sh && cd bld/cfloat && builder rel")
    # Continue with the assemblers/librarian/linker/make
    # system(". ./setvars.sh && cd bld/wasm && builder rel")
    # system(". ./setvars.sh && cd bld/as && builder rel")
    # system(". ./setvars.sh && cd bld/nwlib && builder rel")
    # system(". ./setvars.sh && cd bld/wl && builder rel")
    # system(". ./setvars.sh && cd bld/wmake && builder rel")
    # system(". ./setvars.sh && cd bld/wtouch && builder rel")
    # On to the compilers
    # system(". ./setvars.sh && cd bld/cg && builder rel")
    # system(". ./setvars.sh && cd bld/cc && builder rel")
    # system(". ./setvars.sh && cd bld/plusplus && builder rel")
    # system(". ./setvars.sh && cd bld/f77/wfc && builder rel")
    # Resource tools, first Resource compiler
    # system(". ./setvars.sh && cd bld/rc && builder rel")
    # Continue with SDK tools
    # system(". ./setvars.sh && cd bld/wpi && builder rel")
    # system(". ./setvars.sh && cd bld/commonui && builder rel")
    # system(". ./setvars.sh && cd bld/sdk && builder rel")
    # Now miscellaneous command line tools
    # system(". ./setvars.sh && cd bld/ndisasm && builder rel")
    # system(". ./setvars.sh && cd bld/exedump && builder rel")
    # system(". ./setvars.sh && cd bld/dmpobj && builder rel")
    # system(". ./setvars.sh && cd bld/wcl && builder rel")
    # system(". ./setvars.sh && cd bld/f77/wfl && builder rel")
    # system(". ./setvars.sh && cd bld/wstrip && builder rel")
    # User interface libs
    # system(". ./setvars.sh && cd bld/ncurses && builder rel")
    system(". ./setvars.sh && cd bld/ui && builder rel")
    system(". ./setvars.sh && cd bld/gui && builder rel")
    # system(". ./setvars.sh && cd bld/aui && builder rel")
    # The vi(w) editor
    # system(". ./setvars.sh && cd bld/rcsdll && builder rel")
    # system(". ./setvars.sh && cd bld/vi && builder rel")
    # Build the debugger and sampler
    # system(". ./setvars.sh && cd bld/dip && builder rel")
    # system(". ./setvars.sh && cd bld/mad && builder rel")
    # system(". ./setvars.sh && cd bld/rsilib && builder rel")
    # system(". ./setvars.sh && cd bld/wattcp && builder rel")
    # system(". ./setvars.sh && cd bld/trap && builder rel")
    # system(". ./setvars.sh && cd bld/wv && builder rel")
    # system(". ./setvars.sh && cd bld/wsample && builder rel")
    # GUI tools libraries
    system(". ./setvars.sh && cd bld/wclass && builder rel")
    # Other GUI tools
    # system(". ./setvars.sh && cd bld/wprof && builder rel")
    # system(". ./setvars.sh && cd bld/browser && builder rel")
    # The IDE tools
    # system(". ./setvars.sh && cd bld/editdll && builder rel")
    # system(". ./setvars.sh && cd bld/idebatch && builder rel")
    # system(". ./setvars.sh && cd bld/ide && builder rel")
    # The miscelaneous tools
    # system(". ./setvars.sh && cd bld/cmdedit && builder rel")
    # system(". ./setvars.sh && cd bld/cvpack && builder rel")
    # OW clones for MS tools
    # system(". ./setvars.sh && cd bld/mstools && builder rel")
    # Miscelaneous files
    system(". ./setvars.sh && cd bld/misc && builder rel")
    system(". ./setvars.sh && cd bld/bdiff && builder rel")
    system(". ./setvars.sh && cd bld/techinfo && builder rel")
    # Source code samples
    system(". ./setvars.sh && cd bld/src && builder rel")
    # IDE samples
    system(". ./setvars.sh && cd bld/idedemo && builder rel")
    # Build help viewer
    # system(". ./setvars.sh && cd bld/hlpview && builder rel")
    # Build help compilers
    # system(". ./setvars.sh && cd bld/hcdos && builder rel")
    # system(". ./setvars.sh && cd bld/hcwin && builder rel")
    # system(". ./setvars.sh && cd bld/wipfc && builder rel")
    # system(". ./setvars.sh && cd bld/bmp2eps && builder rel")
    # Copy the redistributable components
    system(". ./setvars.sh && cd bld/redist && builder rel")
    # Build installer tools
    # system(". ./setvars.sh && cd bld/uninstal && builder rel")
    # system(". ./setvars.sh && cd bld/setupgui && builder rel")
    # Build text documents
    system(". ./setvars.sh && cd bld/docstxt && builder rel")
  end

  test do
    system "true"
  end
end
