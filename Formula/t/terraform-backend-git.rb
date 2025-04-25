class TerraformBackendGit < Formula
  desc "Terraform HTTP Backend implementation that uses Git repository as storage"
  homepage "https://github.com/plumber-cd/terraform-backend-git"
  url "https://github.com/plumber-cd/terraform-backend-git/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "96499b4d98cd2337e96f256e79b91f6249f0d57374962296109bf4baae76cd7a"
  license "Apache-2.0"
  head "https://github.com/plumber-cd/terraform-backend-git.git"

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
