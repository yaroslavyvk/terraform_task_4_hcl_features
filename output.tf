output "vm_name_uppercase" {
  value = [for vm in azurerm_virtual_machine.main : upper(vm.name)]
}

output "tags_combined" {
  value = [
    for vm in azurerm_virtual_machine.main : join(", ", [
      vm.tags["name"],
      vm.tags["environment"],
      vm.tags["creation_date"]
    ])
  ]
}

output "vm_ids" {
  value = [for vm in azurerm_virtual_machine.main : vm.id]
}
