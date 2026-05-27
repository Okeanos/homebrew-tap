class Blesh < Formula
  desc "ble.sh is a Bash line editor with syntax highlighting, auto suggestions, etc"
  homepage "https://github.com/akinomyoga/ble.sh"
  url "https://github.com/akinomyoga/ble.sh.git",
      tag:      "v0.4.0-devel3",
      revision: "1a5c451c8baa71439a6be4ea0f92750de35a7620"
  version "0.4.0-devel3"
  license "BSD-3-Clause"
  head "https://github.com/akinomyoga/ble.sh.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+(?:-devel\d+)?)$/i) # allows a "-develN" suffix
    strategy :github_latest
  end

  keg_only "ble.sh needs to be manually setup via .bashrc/.bash_profile inclusion"

  depends_on "gawk" => :build
  depends_on "bash" => :recommended

  def install
    vars = %W[
      PREFIX=#{pkgshare}
      INSDIR_LICENSE=#{pkgshare}
    ]
    ENV.deparallelize # to address https://github.com/akinomyoga/ble.sh/issues/689
    system "make", *vars, "install"

    cd pkgshare/"doc/blesh" do
      prefix.install_metafiles
    end
    rm_r pkgshare/"doc"
  end

  def caveats
    <<~EOS
      The ble.sh script is installed as
        #{opt_prefix/"share/blesh/ble.sh"}
    EOS
  end

  test do
    system "bash", share/"blesh/ble.sh", "--help"

    # In absence of $HOME/.cache, `ble.sh --lib` tries and fails to create files
    # in #{share}/blesh/cache.d, which is outside of the test sandbox.
    (testpath/".cache").mkdir
    system "bash", share/"blesh/ble.sh", "--lib"
  end
end
