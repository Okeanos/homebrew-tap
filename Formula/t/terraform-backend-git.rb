class TerraformBackendGit < Formula
  desc "Terraform HTTP Backend implementation that uses Git repository as storage"
  homepage "https://github.com/plumber-cd/terraform-backend-git"
  url "https://github.com/plumber-cd/terraform-backend-git/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "67c0cf8a11dddd314bae24878a9b757e34a188d721023338640e31d9fd0ca696"
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
