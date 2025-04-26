class Blesh < Formula
  desc "ble.sh is a Bash line editor with syntax highlighting, auto suggestions, etc"
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

  keg_only "ble.sh needs to be manually setup via .bashrc/.bash_profile inclusion"

  option "without-docs", "Disable documentation files"

  depends_on "gawk" => :build
  depends_on "make" => :build
  depends_on "bash" => :recommended

  def install
    args = []
    args << "INSDIR_DOC=no" if build.with? "without-docs"

    system "make", "install", "INSDIR=#{pkgshare}", *args
  end

  def caveats
    <<~EOS
      To setup ble.sh add the following to your .bashrc or .bash_profile:
        [[ $- == *i* ]] && source #{opt_prefix}/share/#{name}/ble.sh --noattach

        # your bashrc settings come here...

        # Add this line at the end of .bashrc or .bash_profile:
        [[ ! ${BLE_VERSION-} ]] || ble-attach
    EOS
  end

  test do
    assert_path_exists "#{pkgshare}/ble.sh"
  end
end
