package br.com.itsjoias.controller;

import br.com.itsjoias.entity.Cliente;
import br.com.itsjoias.repository.ClienteRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/clientes")
@CrossOrigin(origins = "*")
public class ClienteController {

    private final ClienteRepository clienteRepository;

    public ClienteController(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    @PostMapping
    public ResponseEntity<Cliente> criarCliente(
            @RequestBody Cliente cliente) {

        cliente.setId(null);
        Cliente clienteSalvo = clienteRepository.save(cliente);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(clienteSalvo);
    }
}
