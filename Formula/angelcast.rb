class Angelcast < Formula
  desc "Generate, schedule, and play personalized kid-safe podcasts from the terminal"
  homepage "https://angelq.ai"
  version "1.0.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.15/angelcast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "58b076a7701451235a793b50252eeb71ad81ca69095ac3d7454eea93db7fa325"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.15/angelcast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2b9994071ce7c9de8c327b12cfeb45ac8a286513e7e786eb062377c9c9f872a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.15/angelcast-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6c2551ae23d0b007a1047022caa981028c512172076f12cb3dec016bc3edc5c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.15/angelcast-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "cde1005cff64108efc0c0d33c4466df1ae1997245a3b5809f99131485b6bf113"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "angelcast"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "angelcast"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "angelcast"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "angelcast"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
