class Angelcast < Formula
  desc "Generate, schedule, and play personalized kid-safe podcasts from the terminal"
  homepage "https://angelq.ai"
  version "1.0.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.17/angelcast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a75d1e1ff94a12a3b1aca64324e4161211bf7ffc3bc03e5da0dc55c253d12df4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.17/angelcast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c8ad2e8af5fb315cb7902e2090232c5091b8d9c33a99630b75d0abac9034713e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.17/angelcast-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "554ec5f3d35293599532c8c1bdaee2b2f92579a10926e8a15741c47beebabf45"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.17/angelcast-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b18b8532e725782beb5405ab3b64166964ed5c00b08fb0a809fda28840f77744"
    end
  end

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
