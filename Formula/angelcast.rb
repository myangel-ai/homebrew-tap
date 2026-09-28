class Angelcast < Formula
  desc "Generate, schedule, and play personalized kid-safe podcasts from the terminal"
  homepage "https://angelq.ai"
  version "1.0.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.11/angelcast-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3d5cf93327bce1de53169a832adc198f41088c9a9349f97241df4b769ff6d575"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.11/angelcast-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2ebd3450a0afc4632690160a062a88f30e770b17833a172a03dfbf35915d9f04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.11/angelcast-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a2b39651a3572bff902fdf77bcde2bc0345e32c33c9c4e160e15a89a09231775"
    end
    if Hardware::CPU.intel?
      url "https://github.com/myangel-ai/angelcast-cli/releases/download/angelcast-cli-v1.0.11/angelcast-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a8eb7b472d1ca89f1536f7a8f744a97966efc967d8aeb7309ea7d9ea3597f01c"
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
