data "template_file" "files" {
  for_each = var.template_files

  template = file(each.value.template)
  vars     = each.value.vars
}
