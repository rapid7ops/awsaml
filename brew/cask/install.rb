cask "install" do
    version "3.1.3"
    sha256 "1cf9093156370380b328e3250a3ff7649968aee78c8bfcb09badbcdec05e36a0"

    url "https://github.com/rapid7ops/awsaml/releases/download/v3.1.3/Awsaml-darwin-universal-3.1.3.zip"
    name "awsaml"
    desc "Awsaml is an application for providing automatically rotated temporary AWS credentials."
    homepage "https://github.com/r7ops/awsaml"

    arch = Hardware::CPU.arm? ? "arm64" : "x86_64"

    preflight do
      system_command "/usr/bin/git",
                     args: ["clone", "https://github.com/rapid7ops/awsaml", "/tmp/awsaml"]
    end
  
    preflight do
        system_command "/bin/mkdir",
                       args: ["-p", "#{ENV["HOME"]}/Library/LaunchAgents"]
     end 
  
    preflight do
        system_command "/usr/bin/unzip",
                       args: ["/tmp/awsaml/src/main/containers/awsaml.zip", "-d", "#{ENV["HOME"]}/Library/"]
      end     

    preflight do
        system_command "/bin/chmod",
                       args: ["+x", "#{ENV["HOME"]}/Library/awsaml-update.sh"]
      end 

    preflight do
        system_command "/bin/bash",
                       args: ["#{ENV["HOME"]}/Library/awsaml-update.sh"]
      end

    app "awsaml.app"

end
