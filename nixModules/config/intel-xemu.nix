{pkgs, lib, config, ...}:
{
  options = {
    intel-qemu-conf.enable = lib.mkEnableOption "enables config";
  };
  config = lib.mkIf config.intel-qemu-conf.enable {
      boot.kernelParams = [
        intel_iommu=on 
        i915.enable_guc=3 
        i915.max_vfs=7 
        module_blacklist=xe
        kvm.ignore_msrs=1
      ];    
      boot.extraModulePackages = [ pkgs.i915-sriov ]; # hypothetical; requires you to supply/pack inherit 
      boot.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" "kvm" "kvm_intel" ];
      virtualisation.libvirtd.enable = true;

      # Enable virtualization stack
      virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm; # QEMU with KVM support

      programs.virt-manager.enable = true; 
      users.users.lubrin.extraGroups = [ "libvirtd" "kvm" ];
  };
}
