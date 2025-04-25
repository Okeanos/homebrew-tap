class Blesh < Formula
  desc "Bash Line Editor―a line editor written in pure Bash with syntax highlighting, auto suggestions, vim modes, etc. for Bash interactive sessions."
  homepage "https://github.com/akinomyoga/ble.sh"
  url "https://github.com/akinomyoga/ble.sh/archive/refs/tags/v0.4.0-devel3.tar.gz", tag: "v0.4.0-devel3", revision: "1a5c451c8baa71439a6be4ea0f92750de35a7620"
  sha256 "867ec9681bd75de7faa93622bcae1b705f561c11d83a62ead1f14554b87630dc"
  license "BSD-3-Clause"
  head "https://github.com/akinomyoga/ble.sh.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  def caveats
    s = <<-EOS.undent
      # Add this lines at the top of .bashrc:
      [[ $- == *i* ]] && source /path/to/blesh/ble.sh --noattach

      # your bashrc settings come here...

      # Add this line at the end of .bashrc:
      [[ ! ${BLE_VERSION-} ]] || ble-attach
    EOS
    s
  end

  depends_on "make"
  depends_on "gawk"

  option "without-docs", "Disable documentation files"

  def install
    args = []
    args << "INSDIR_DOC=no" if build.with? "without-docs"

    system "make", "install", "INSDIR=#{share}", *args
  end

  test do
    assert_path_exists "#{share}/ble.sh"
  end
end
