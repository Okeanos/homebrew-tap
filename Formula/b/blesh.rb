class Blesh < Formula
  desc "Bash Line Editor―a line editor written in pure Bash with syntax highlighting, auto suggestions, vim modes, etc. for Bash interactive sessions."
  homepage "https://github.com/akinomyoga/ble.sh"
  url "https://github.com/akinomyoga/ble.sh.git",
      tag: "v0.4.0-devel3",
      revision: "1a5c451c8baa71439a6be4ea0f92750de35a7620"
  license "BSD-3-Clause"
  head "https://github.com/akinomyoga/ble.sh.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  keg_only "ble.ssh needs to be manually setup via .bashrc inclusion. It is useless on the PATH."

  def caveats
    <<~EOS
      # Add this line at the top of your .bashrc:
      [[ $- == *i* ]] && source #{bin}/blesh/ble.sh --noattach

      # your bashrc settings come here...

      # Add this line at the end of .bashrc:
      [[ ! ${BLE_VERSION-} ]] || ble-attach
    EOS
  end

  depends_on "make"
  depends_on "gawk"

  option "without-docs", "Disable documentation files"

  def install
    args = []
    args << "INSDIR_DOC=no" if build.with? "without-docs"

    system "make", "install", "INSDIR=#{bin}", *args
  end

  test do
    assert_path_exists "#{bin}/ble.sh"
    assert_match version.to_s, shell_output("bash -c #{bin}/ble-sh --version 2>&1")
  end
end
