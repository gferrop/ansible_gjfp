# despegue_configuracion_was_f5_isva

Descripción no disponible.

## Detalles

```yaml
---
# - name: Crear una VM WAS y una VM DB desde campos individuales del Survey y configurar F5
#   hosts: localhost
#   gather_facts: false
#   vars:
#    isva_ip: "{{ lookup('env', 'ISVA_IP') }}"
#    isva_user: "{{ lookup('env', 'ISVA_USER') }}"
#    isva_password: "{{ lookup('env', 'ISVA_PASSWORD') }}"
#    proxy_admin_id: "{{ lookup('env', 'SECMASTER_USERNAME') }}"
#    proxy_admin_pwd: "{{ lookup('env', 'SECMASTER_PASSWORD') }}"

#   tasks:
    # - name: Consultar toda la información de BIG-IQ
    #   f5networks.f5_modules.bigip_device_info:
    #     gather_subset:
    #       - vlans
    #       - ltm-pools
    #       - nodes
    #       - virtual-servers
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #   register: bigiq_info
    #   delegate_to: localhost

    # - name: Mostrar información recolectada de BIG-IQ
    #   debug:
    #     var: bigiq_info

    #Construir 'was_list' desde campos individuales del Survey
    # - name: Construir 'was_list' desde campos individuales del Survey
    #   set_fact:
    #     was_list_str:
    #       - name: "{{ was_name }}"
    #         memory_gb: "{{ was_memory_gb }}"
    #         num_cpus: "{{ was_num_cpus }}"
    #         cpu_cores_per_socket: "{{ was_cpu_cores_per_socket | default(1) }}"
    #         network_name: "{{ was_network_name | default('') }}"
    #         ip: "{{ was_ip }}"
    #         netmask: "{{ was_netmask }}"
    #         gateway: "{{ was_gateway | default('') }}"
    #         vlan: "{{ was_vlan | default('') }}"
    #         datastore: "{{ was_datastore }}"

    # - name: Convertir 'was_list_str' en lista real
    #   set_fact:
    #     was_list: "{{ was_list_str | from_yaml }}"

    # Construir 'db_vm' desde campos individuales del Survey
    # - name: Construir 'db_vm' desde campos individuales del Survey
    #   set_fact:
    #    db_vm_str: |-
    #      name: "{{ db_name }}"
    #      memory_gb: {{ db_memory_gb }}
    #      num_cpus: {{ db_num_cpus }}
    #      cpu_cores_per_socket: {{ db_cpu_cores_per_socket | default(1) }}
    #      network_name: "{{ db_network_name | default('') }}"
    #      ip: "{{ db_ip }}"
    #      netmask: "{{ db_netmask }}"
    #      gateway: "{{ db_gateway | default('') }}"
    #      vlan: "{{ db_vlan | default('') }}"
    #      datastore: "{{ db_datastore }}"

    # - name: Convertir 'db_vm_str' en diccionario real
    #   set_fact:
    #     db_vm: "{{ db_vm_str | from_yaml }}"

    # Crear VM WAS desde template WAS
    # - name: Crear VM WAS desde template WAS
    #   community.vmware.vmware_guest:
    #     hostname: "{{ lookup('env', 'VCENTER_HOSTNAME') }}"
    #     username: "{{ lookup('env', 'VCENTER_USERNAME') }}"
    #     password: "{{ lookup('env', 'VCENTER_PASSWORD') }}"
    #     validate_certs: "{{ vcenter_validate_certs | default(false) }}"
    #     datacenter: "{{ datacenter }}"
    #     cluster: "{{ cluster_was }}"
    #     folder: "{{ folder_vcenter }}"
    #     template: "{{ was_template }}"
    #     name: "{{ item.name }}"
    #     state: poweredon
    #     datastore: "{{ item.datastore }}"
    #     # esxi_hostname: "cpprevi178.bbva.ve.corp"          
    #     hardware:
    #       memory_mb: "{{ (item.memory_gb | float * 1024) | int }}"
    #       num_cpus: "{{ item.num_cpus }}"
    #       num_cpu_cores_per_socket: "{{ item.cpu_cores_per_socket }}"
    #       boot_firmware: efi
    #       hotadd_cpu: true # Permitir agregar CPU en caliente
    #       hotremove_cpu: true # Permitir remover CPU en caliente
    #       hotadd_memory: true # Permitir agregar memoria en caliente
    #     networks:
    #       - name: "{{ item.network_name }}"
    #         device_type: vmxnet3
    #         ip: "{{ item.ip }}"
    #         netmask: "{{ item.netmask }}"
    #         gateway: "{{ item.gateway }}"
    #         vlan_id: "{{ item.vlan }}"
    #         type: static
    #         connected: true
    #     wait_for_ip_address: true
    #   loop: "{{ was_list }}"
    #   register: deploy_was
    #   delegate_to: localhost

    # # Crear VM DB desde template DB
    # - name: Crear VM DB desde template DB
    #   community.vmware.vmware_guest:
    #     hostname: "{{ lookup('env', 'VCENTER_HOSTNAME') }}"
    #     username: "{{ lookup('env', 'VCENTER_USERNAME') }}"
    #     password: "{{ lookup('env', 'VCENTER_PASSWORD') }}"
    #     validate_certs: "{{ vcenter_validate_certs | default(false) }}"
    #     datacenter: "{{ datacenter }}"
    #     cluster: "{{ cluster_db }}"
    #     folder: "{{ folder_vcenter_db }}"
    #     template: "{{ db_template }}"
    #     name: "{{ db_vm.name }}"
    #     state: poweredon
    #     datastore: "{{ db_vm.datastore }}"
    #     # esxi_hostname: "cpprevi178.bbva.ve.corp"      
    #     hardware:
    #       memory_mb: "{{ (db_vm.memory_gb | float * 1024) | int }}"
    #       num_cpus: "{{ db_vm.num_cpus }}"
    #       num_cpu_cores_per_socket: "{{ db_vm.cpu_cores_per_socket }}"
    #       boot_firmware: efi
    #       hotadd_cpu: true # Permitir agregar CPU en caliente
    #       hotremove_cpu: true # Permitir remover CPU en caliente
    #       hotadd_memory: true # Permitir agregar memoria en caliente
    #     networks:
    #       - name: "{{ db_vm.network_name }}"
    #         device_type: vmxnet3
    #         ip: "{{ db_vm.ip }}"
    #         netmask: "{{ db_vm.netmask }}"
    #         gateway: "{{ db_vm.gateway }}"
    #         vlan_id: "{{ db_vm.vlan }}"
    #         type: static
    #         connected: true
    #     wait_for_ip_address: true
    #   register: deploy_db

    # - name: Registro obligatorio con Satellite
    #   block:
    #     - name: Generar comando de registro con Satellite
    #       redhat.satellite.registration_command:
    #         organization: BBVA Provincial
    #         activation_keys: "{{ satellite_activation_key }}"
    #         setup_insights: true
    #         location: Venezuela
    #         setup_remote_execution: true
    #         force: true
    #         insecure: true
    #         validate_certs: false
    #         password: "{{ lookup('env', 'SATELLITE_PASSWORD') }}"
    #         server_url: "{{ lookup('env', 'SATELLITE_SERVER_URL') }}"
    #         username: "{{ lookup('env', 'SATELLITE_USERNAME') }}"
    #       no_log: false
    #       register: command
    #       when: ansible_facts['os_family'] == "RedHat"

    #     - name: "Perform registration"
    #       become: true
    #       ansible.builtin.shell:
    #         cmd: "{{ command.registration_command }}"
    #       when: ansible_facts['os_family'] == "RedHat"

    # - name: Crear VLAN en F5
    #   f5networks.f5_modules.bigip_vlan:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     name: "{{ vlan_name }}"
    #     state: present
    #     tagged_interfaces:
    #       - "{{ vlan_interface }}"
    #     partition: Common

    # - name: Crear Self IP en F5
    #   f5networks.f5_modules.bigip_selfip:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     name: "SelfIP_{{ vlan_name }}"
    #     partition: Common
    #     address: "{{ self_ip }}"
    #     netmask: "{{ self_ip_mask }}"
    #     vlan: "/Common/{{ vlan_name }}"
    #   register: selfip_result

    # - name: Crear Virtual Server inicial en F5 (sin Pool)
    #   f5networks.f5_modules.bigip_virtual_server:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     name: "{{ virtual_server_name }}"
    #     destination: "{{ self_ip }}"
    #     port: "{{ virtual_server_port }}"
    #     enabled_vlans:
    #       - "/Common/{{ vlan_name }}"
    #     partition: Common
    #     state: present

    # - name: Crear Pool en F5 si no existe
    #   f5networks.f5_modules.bigip_pool:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     name: "{{ pool_name }}"
    #     lb_method: "round-robin"
    #     partition: Common
    #     state: present
    #   register: pool_creation
    #   delegate_to: localhost

    # - name: Crear nodos en F5 (usando hostname de la máquina)
    #   f5networks.f5_modules.bigip_node:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     name: "{{ item.name }}"
    #     state: present
    #     address: "{{ item.ip }}"
    #     partition: Common
    #   loop: "{{ was_list + [ db_vm ] }}"

    # # Construir lista de miembros para el Pool
    # - name: Construir lista de miembros para el Pool
    #   set_fact:
    #     pool_members: "{{ pool_members | default([]) + [ {'name': item.name ~ ':' ~ pool_port|string, 'address': item.ip, 'port': pool_port } ] }}"
    #   loop: "{{ was_list + [ db_vm ] }}"

    # - name: Obtener los nodos existentes en el BIG-IP
    #   set_fact:
    #     existing_node_ips: "{{ ansible_net_nodes | map(attribute='address') | list }}"

    # - name: Mostrar las IPs existentes para depuración
    #   debug:
    #     var: existing_node_ips

    # - name: Verificar y agregar miembros al Pool F5 si la IP no existe
    #   f5networks.f5_modules.bigip_pool_member:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     pool: "{{ pool_name }}"
    #     state: present
    #     address: "{{ item.address }}"
    #     port: "{{ item.port }}"
    #     partition: Common
    #   loop: "{{ pool_members }}"
    #   when: item.address not in existing_node_ips  # Verificar si la IP ya está en uso
    #   delegate_to: localhost

    # - name: Crear Virtual Server con Pool en F5
    #   f5networks.f5_modules.bigip_virtual_server:
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #       server_port: 443
    #       transport: rest
    #     pool: "{{ pool_name }}"
    #     name: "{{ virtual_server_name }}"
    #     destination: "{{ self_ip }}"
    #     port: "{{ virtual_server_port }}"
    #     enabled_vlans:
    #       - "/Common/{{ vlan_name }}"
    #     partition: Common
    #     state: present

    # - name: Consultar toda la información de BIG-IQ
    #   f5networks.f5_modules.bigip_device_info:
    #     gather_subset:
    #       - vlans
    #       - ltm-pools
    #       - nodes
    #       - virtual-servers
    #     provider:
    #       server: "{{ lookup('env', 'F5_HOST') }}"
    #       user: "{{ lookup('env', 'F5_USER') }}"
    #       password: "{{ lookup('env', 'F5_PASSWORD') }}"
    #       validate_certs: false
    #   register: bigiq_info
    #   delegate_to: localhost

    # - name: Obtener la configuración de interfaces de red
    #   command: >
    #     curl -X GET "https://{{ isva_ip }}/net/ifaces"
    #     -u "{{ isva_user }}:{{ isva_password }}"
    #     -H "Accept: application/json" --insecure
    #   register: interfaces_output
    #   changed_when: false

    # - name: Parsear la salida JSON de interfaces
    #   set_fact:
    #     interfaces_data: "{{ interfaces_output.stdout | from_json }}"

    # - name: Extraer UUID y nombre de la interfaz VLAN con label "{{ vlan_interface_name }}"
    #   set_fact:
    #     webseal_vlan_uuid: >-
    #         {{
    #         interfaces_data.interfaces
    #         | selectattr('label', 'equalto', vlan_interface_name)
    #         | map(attribute='uuid')
    #         | list
    #         | first | default('')
    #         }}
    #     webseal_vlan_name: >-
    #         {{
    #         interfaces_data.interfaces
    #         | selectattr('label', 'equalto', vlan_interface_name)
    #         | map(attribute='name')
    #         | list
    #         | first | default('')
    #         }}

    # - name: Verificar que se encontró la interfaz VLAN con label "{{ vlan_interface_name }}"
    #   fail:
    #     msg: "No se encontró la interfaz VLAN con label {{ vlan_interface_name }}"
    #   when: webseal_vlan_uuid == ""

    # - name: Extraer direcciones IP existentes en la interfaz VLAN "{{ vlan_interface_name }}"
    #   set_fact:
    #     existing_ipv4_addresses: >-
    #         {{
    #         interfaces_data.interfaces
    #         | selectattr('uuid', 'equalto', webseal_vlan_uuid)
    #         | map(attribute='ipv4.addresses')
    #         | list
    #         | first | default([])
    #         }}

    # - name: Verificar si la IP ya existe en la VLAN "{{ vlan_interface_name }}"
    #   set_fact:
    #     ip_already_exists: >-
    #         {{ ipv4_address in (existing_ipv4_addresses | map(attribute='address') | list) }}

    # - name: Construir nueva lista de direcciones IP
    #   set_fact:
    #     updated_ipv4_addresses: >-
    #         {{ existing_ipv4_addresses + [{
    #             "objType": "ipv4Address",
    #             "address": ipv4_address,
    #             "maskOrPrefix": ipv4_mask,
    #             "allowManagement": false,
    #             "isPrimary": false,
    #             "enabled": true
    #         }] if not ip_already_exists else existing_ipv4_addresses }}

    # - name: Agregar direcciones IPv4 a la interfaz existente
    #   command: >
    #     curl -X PUT "https://{{ isva_ip }}/net/ifaces/{{ webseal_vlan_uuid }}"
    #     -u "{{ isva_user }}:{{ isva_password }}"
    #     -H "Accept: application/json"
    #     -H "Content-Type: application/json"
    #     -d '{
    #             "name": "{{ webseal_vlan_name }}",
    #             "comment": "",
    #             "enabled": true,
    #             "vlanId": null,
    #             "bondingMode": "none",
    #             "bondedTo": "",
    #             "ipv4": {
    #             "dhcp": {
    #                 "enabled": false,
    #                 "allowManagement": false,
    #                 "providesDefaultRoute": false,
    #                 "routeMetric": null
    #             },
    #             "addresses": {{ updated_ipv4_addresses | to_json }}
    #             },
    #             "ipv6": {
    #             "dhcp": {
    #                 "enabled": false,
    #                 "allowManagement": false
    #             },
    #             "addresses": []
    #             }
    #         }'
    #     --insecure
    #   when: not ip_already_exists

    # - name: Configurar Reverse Proxy con curl
    #   command: >
    #     curl -X POST "https://{{ isva_ip }}/wga/reverseproxy"
    #     -u "{{ isva_user }}:{{ isva_password }}"
    #     -H "Accept: application/json"
    #     -d '{
    #             "inst_name": "{{ proxy_instance_name }}",
    #             "host": "{{ proxy_host }}",
    #             "listening_port": "{{ proxy_listening_port }}",
    #             "domain": "{{ proxy_domain }}",
    #             "admin_id": "{{ proxy_admin_id }}",
    #             "admin_pwd": "{{ proxy_admin_pwd }}",
    #             "ssl_yn": "{{ proxy_ssl_yn }}",
    #             "key_file": "{{ proxy_key_file }}",
    #             "cert_label": "{{ proxy_cert_label }}",
    #             "ssl_port": "{{ proxy_ssl_port }}",
    #             "http_yn": "{{ proxy_http_yn }}",
    #             "http_port": "{{ proxy_http_port }}",
    #             "https_yn": "{{ proxy_https_yn }}",
    #             "https_port": "{{ proxy_https_port }}",
    #             "nw_interface_yn": "{{ proxy_nw_interface_yn }}",
    #             "ip_address": "{{ proxy_ip_address }}"
    #         }'
    #     --insecure

    # - name: Crear Junction en Reverse Proxy con curl
    #   command: >
    #     curl -X POST "https://{{ isva_ip }}/wga/reverseproxy/{{ proxy_instance_name }}/junctions"
    #     -u "{{ isva_user }}:{{ isva_password }}"
    #     -H "Accept: application/json"
    #     -d '{
    #             "junction_point": "{{ junction_point }}",
    #             "description": "{{ junction_description }}",
    #             "junction_type": "{{ junction_type }}",
    #             "server_hostname": "{{ backend_server_hostname }}",
    #             "server_port": "{{ backend_server_port }}",
    #             "authz_rules": "no",
    #             "case_insensitive_url": "no",
    #             "client_ip_http": "no",
    #             "enable_basic_auth": "no",
    #             "insert_ltpa_cookies": "no",
    #             "insert_session_cookies": "no",
    #             "mutual_auth": "no",
    #             "preserve_cookie": "no",
    #             "transparent_path_junction": "no",
    #             "windows_style_url": "no"
    #         }'
    #     --insecure

    # - name: Publicar cambios pendientes
    #   command: >
    #     curl -X PUT "https://{{ isva_ip }}/isam/pending_changes?publish=true"
    #     -u "{{ isva_user }}:{{ isva_password }}"
    #     -H "Accept: application/json"
    #     --insecure

- name: Instalar WebSphere Application Server (WAS) en Red Hat
  hosts: was_servers
  become: true
  gather_facts: true
  vars:
    was_install_dir: /opt/IBM/WebSphere/AppServer  # Directorio de instalación de WAS
    was_user: wasadmin  # Usuario para ejecutar WAS
    was_group: wasgroup  # Grupo para el usuario de WAS
    was_profile_name: AppSrv01 # Nombre del perfil de WAS
    was_cell_name: MyCell01 # Nombre de la celda de WAS
    was_node_name: MyNode01 # Nombre del nodo de WAS
    was_server_name: server1 # Nombre del servidor de WAS
    was_admin_user: wasadmin # Usuario administrador de WAS
    was_admin_password: "your_was_admin_password" # Contraseña del usuario administrador de WAS (¡CAMBIAR!)
    was_response_file: /tmp/was_install_response.xml # Ruta del archivo de respuesta para la instalación
    was_profile_response_file: /tmp/was_profile_response.xml # Ruta del archivo de respuesta para la creación del perfil
    im_install_dir: /opt/IBM/InstallationManager # Directorio de instalación de IBM Installation Manager
    was_repository_location: /path/to/was/repository # Ruta al repositorio de WAS (¡CAMBIAR!)
    im_repository_location: /path/to/im/repository # Ruta al repositorio de IM (¡CAMBIAR!)
    was_version: 9.0.5.14 # Version de WAS a instalar (¡CAMBIAR!)
    was_fixpack_repository_location: /path/to/was/fixpack/repository # Ruta al repositorio del fixpack de WAS (¡CAMBIAR!)
    was_fixpack_version: 9.0.5.14 # Version del fixpack de WAS a instalar (¡CAMBIAR!)
    was_fixpack_id: 9.0.5.14-WS-WAS-IFPH46379 # ID del fixpack de WAS a instalar (¡CAMBIAR!)
    was_install_package_id: com.ibm.websphere.ND.v90 # ID del paquete de instalación de WAS (¡CAMBIAR!)
    was_fixpack_package_id: com.ibm.websphere.ND.v90_9.0.5017.20230922_1017 # ID del paquete de fixpack de WAS (¡CAMBIAR!)

  tasks:
    - name: Create group for WAS
      ansible.builtin.group:
        name: "{{ was_group }}"
        state: present    

    - name: Crear usuario para WAS
      ansible.builtin.user:
        name: "{{ was_user }}"
        group: "{{ was_group }}"
        create_home: true
        home: /home/{{ was_user }}
        state: present

    - name: Asegurar que el directorio de instalación de WAS exista
      ansible.builtin.file:
        path: "{{ was_install_dir }}"
        state: directory
        owner: "{{ was_user }}"
        group: "{{ was_group }}"
        mode: '0755'

    - name: Asegurar que el directorio de instalación de IM exista
      ansible.builtin.file:
        path: "{{ im_install_dir }}"
        state: directory
        owner: "{{ was_user }}"
        group: "{{ was_group }}"
        mode: '0755'
        
- name: Usar copy y fetch en un solo playbook
  hosts: servidores
  become: yes
  tasks:
    # Copiar archivo desde el controlador a un servidor remoto
    - name: Copiar hola.txt al servidor remoto
      ansible.builtin.copy:
        src: files/was_install_response.xml  # Archivo local en el controlador
        dest: /files/was_install_response.xml  # Ruta destino en el servidor remoto
        mode: '0644'

    # Obtener archivo desde el servidor remoto al controlador
    - name: Descargar hola.txt desde el servidor remoto al controlador
      ansible.builtin.fetch:
        src: files/was_install_response.xml  # Archivo en el servidor remoto
        dest: ./archivos_descargados/was_install_response.xml  # Ruta local en el controlador
        flat: yes


    - name: Copiar archivo de respuesta de instalación de WAS
      ansible.builtin.copy:
        src: files/was_install_response.xml # Asegúrate de que este archivo exista en tu directorio 'files'
        dest: "{{ was_response_file }}"
        owner: "{{ was_user }}"
        group: "{{ was_group }}"
        mode: '0644'

    - name: Copiar archivo de respuesta de creación de perfil de WAS
      ansible.builtin.copy:
        src: files/was_profile_response.xml # Asegúrate de que este archivo exista en tu directorio 'files'
        dest: "{{ was_profile_response_file }}"
        owner: "{{ was_user }}"
        group: "{{ was_group }}"
        mode: '0644'

    - name: Instalar IBM Installation Manager
      ansible.builtin.shell: |
        cd {{ im_install_dir }}
        ./installc -acceptLicense -installationDirectory {{ im_install_dir }} -repositories {{ im_repository_location }}
      args:
        creates: "{{ im_install_dir }}/eclipse/tools/imcl"
      become_user: "{{ was_user }}"

    - name: Instalar WebSphere Application Server
      ansible.builtin.shell: |
        {{ im_install_dir }}/eclipse/tools/imcl install {{ was_install_package_id }}
        -repositories {{ was_repository_location }}
        -installationDirectory {{ was_install_dir }}
        -acceptLicense
        -showProgress
        -response {{ was_response_file }}
      args:
        creates: "{{ was_install_dir }}/bin/versionInfo.sh"
      become_user: "{{ was_user }}"

    - name: Instalar Fixpack de WebSphere Application Server
      ansible.builtin.shell: |
        {{ im_install_dir }}/eclipse/tools/imcl install {{ was_fixpack_package_id }}
        -repositories {{ was_fixpack_repository_location }}
        -installationDirectory {{ was_install_dir }}
        -acceptLicense
        -showProgress
      args:
        creates: "{{ was_install_dir }}/properties/version/nif/{{ was_fixpack_id }}"
      become_user: "{{ was_user }}"

    - name: Crear perfil de WebSphere Application Server
      ansible.builtin.shell: |
        {{ was_install_dir }}/bin/manageprofiles.sh -create -profileName {{ was_profile_name }} -profilePath {{ was_install_dir }}/profiles/{{ was_profile_name }} -templatePath {{ was_install_dir }}/profileTemplates/default -serverName {{ was_server_name }} -nodeName {{ was_node_name }} -cellName {{ was_cell_name }} -adminUserName {{ was_admin_user }} -adminPassword {{ was_admin_password }} -response {{ was_profile_response_file }}
      args:
        creates: "{{ was_install_dir }}/profiles/{{ was_profile_name }}/logs/AboutThisProfile.txt"
      become_user: "{{ was_user }}"

    - name: Iniciar el servidor de WebSphere Application Server
      ansible.builtin.shell: |
        {{ was_install_dir }}/profiles/{{ was_profile_name }}/bin/startServer.sh {{ was_server_name }}
      become_user: "{{ was_user }}"
      ignore_errors: true # Ignorar errores si el servidor ya está iniciado

    - name: Verificar el estado del servidor de WebSphere Application Server
      ansible.builtin.shell: |
        {{ was_install_dir }}/profiles/{{ was_profile_name }}/bin/serverStatus.sh {{ was_server_name }} -username {{ was_admin_user }} -password {{ was_admin_password }}
      become_user: "{{ was_user }}"
      register: was_status
      changed_when: false

    - name: Mostrar el estado del servidor de WebSphere Application Server
      ansible.builtin.debug:
        msg: "{{ was_status.stdout_lines }}"
```

