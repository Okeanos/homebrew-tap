class TerraformBackendGit < Formula
  desc "Terraform HTTP Backend implementation that uses Git repository as storage"
  homepage "https://github.com/plumber-cd/terraform-backend-git"
  url "https://github.com/plumber-cd/terraform-backend-git/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "a130bb688fe825388d55d2a5f0ad7f9a4affdb40963a2d43d4abb4095830396d"
  license "Apache-2.0"
  head "https://github.com/plumber-cd/terraform-backend-git.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    system "go", "build",
           *std_go_args(ldflags: "-X 'github.com/plumber-cd/terraform-backend-git/cmd.Version=#{version}'")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/terraform-backend-git version 2>&1")
  end
end
