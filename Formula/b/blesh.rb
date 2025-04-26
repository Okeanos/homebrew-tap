class Blesh < Formula
  desc "Bash line editor with syntax highlighting, auto suggestions, etc"
  homepage "https://github.com/akinomyoga/ble.sh"
  url "https://github.com/akinomyoga/ble.sh.git",
      tag:      "v0.4.0-devel3",
      revision: "1a5c451c8baa71439a6be4ea0f92750de35a7620"
  version "0.4.0"
  license "BSD-3-Clause"
  head "https://github.com/akinomyoga/ble.sh.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  keg_only "blesh needs to be manually setup via .bashrc inclusion"

  option "without-docs", "Disable documentation files"

  depends_on "gawk" => :build
  depends_on "make" => :build

  def install
    args = []
    args << "INSDIR_DOC=no" if build.with? "without-docs"

    system "make", "install", "INSDIR=#{bin}", *args
  end

  def caveats
    <<~EOS
      To setup blesh add the following to your .bashrc or .bash_profile:
        [[ $- == *i* ]] && source #{bin}/ble.sh --noattach

        # your bashrc settings come here...

        # Add this line at the end of .bashrc:
        [[ ! ${BLE_VERSION-} ]] || ble-attach
    EOS
  end

  test do
    assert_path_exists "#{bin}/ble.sh"
    assert_match version.to_s, shell_output("bash -c #{bin}/ble.sh --version 2>&1")
  end
end
