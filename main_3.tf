# Провайдер Vagrant для управления VM
provider "vagrant" {
  # Доп_опции
}

resource "vagrant_box" "example" {
  # Имя ОС
  name = "ubuntu/bionic64"
}

resource "vagrant_vm" "example" {
  # Задаем имя VM
  name = "example-vm"
  
  # Для создания VM будет использован Vagrant Box
  box  = vagrant_box.example.name

  # Настройка сети для виртуальной машины
  network {
    # Указываем тип - частная сеть и static IP
    type = "private_network"
    ip   = "192.168.50.4"
  }

  # Настройка синхронизации папок между хостом и гостевой ОС
  synced_folder {
    # Путь на хостовой машине, который будет синхронизироваться
    host_path = "/path/to/local/folder"
    
    # Путь внутри виртуальной машины, куда будет монтироваться синхронизируемая папка
    guest_path = "/vagrant_data"
    
    # Включаем синхронизацию папок
    disabled = false
    
    # Создаем папку на хосте, если она не существует
    create = true
  }

  provisioner "shell" {
    inline = ["echo Hello, Vagrant!"]
  }
}
