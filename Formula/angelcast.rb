class Angelcast < Formula
  desc "Generate, schedule, and play personalized kid-safe podcasts from the terminal"
  homepage "https://angelq.ai"
  version "1.0.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.10/angelcast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d2ffd899c4e9d3733f1c8ec47105dc73761bd0a1300fee6b92a3d1a73f559e69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.10/angelcast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "957a0abf2410f065fd27611a9313930b57070bd0d8e0e74bdf21048be383cf07"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.10/angelcast-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3be8e834ae23ae1179a5e807dc67db9a9fc16e5842bdb0398883403890705d17"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.10/angelcast-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2a65fcaf25f409373b50eee90545bc923b37ae0e24277c1d51af55b5d2412150"
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
