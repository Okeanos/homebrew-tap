class TerraformBackendGit < Formula
  desc "Terraform HTTP Backend implementation that uses Git repository as storage"
  homepage "https://github.com/plumber-cd/terraform-backend-git"
  url "https://github.com/plumber-cd/terraform-backend-git/archive/refs/tags/v0.1.12.tar.gz"
  sha256 "fff19f55912828ee3df11dc695ef35f7f46337c942679389fd281c276d46f107"
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
