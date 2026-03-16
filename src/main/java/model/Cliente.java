package model;

import java.math.BigDecimal;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
	private String cpf;
	private String nome;
	private String email;
	private BigDecimal limite;
	private LocalDate dtNasc;
}
