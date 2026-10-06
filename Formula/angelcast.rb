class Angelcast < Formula
  desc "Generate, schedule, and play personalized kid-safe podcasts from the terminal"
  homepage "https://angelq.ai"
  version "1.0.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.16/angelcast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c620624a2dd7fd8abdfc4799740ce0469488a43a775295cfedf07b87a9a6f124"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.16/angelcast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9406fe4dca0eba3cdbac5146a02a5f8aa94caa61913e7c5f837926a1d152a2e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.16/angelcast-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6bc81e5e1768c3c674f2e9526311cdbece9df52db174a1cb9cf550053ec0c15c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.16/angelcast-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ea7b53897ba847bf166bca62c2d9da67f509c128e5fd1d4dd5ef2de0c37e26ce"
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
