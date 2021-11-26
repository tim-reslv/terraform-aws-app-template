resource "aws_network_interface_attachment" "network_interface_attachments" {
  for_each = {
    for nic_key, nic_value in var.network_interfaces : nic_key => nic_value
    if nic_value.attachment_device_index != 0
  }

  instance_id          = aws_instance.instances[each.value.attachment_instance_key].id
  network_interface_id = aws_network_interface.network_interfaces[each.key].id
  device_index         = each.value.attachment_device_index
}
