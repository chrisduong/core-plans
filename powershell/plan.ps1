$pkg_name="powershell"
$pkg_origin="core"
$pkg_version="6.0.0-alpha.17"
$pkg_license=@("MIT")
$pkg_upstream_url="https://msdn.microsoft.com/powershell"
$pkg_description="PowerShell is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models. It includes a command-line shell, an associated scripting language and a framework for processing cmdlets."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/PowerShell/PowerShell/releases/download/v$pkg_version/PowerShell_$pkg_version-win7-win2008r2-x64.zip"
$pkg_shasum="13b573e8352d1106378fe67bacbead5e9b6159fe89a287662f87e6f3be9035dd"
$pkg_filename="powershell-$pkg_version-win7-win2k8r2-x64.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
  $versionTable = ./powershell.exe -command '$PSVersionTable'
  $passed = $false

  $versionTable | % {
    if($_.Trim().StartsWith('GitCommitId')) {
        $passed = $_.Trim().EndsWith($pkg_version)
    }
  }

  if(!$passed) {
    Write-Error "Check failed to confirm powershell version as $pkg_version"
  }
}
