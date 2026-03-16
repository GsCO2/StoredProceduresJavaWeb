package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.Cliente;
public class ClienteDao implements ICrudDao<Cliente> {
	
	private GenericDao gDao;

	public ClienteDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String inserir(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "I");
		cs.setString(2, c.getCpf());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getEmail());
		cs.setBigDecimal(5, c.getLimite());
		cs.setString(6, c.getDtNasc().toString());
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String alterar(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "U");
		cs.setString(2, c.getCpf());
		cs.setString(3, c.getNome());
		cs.setString(4, c.getEmail());
		cs.setBigDecimal(5, c.getLimite());
		cs.setString(6, c.getDtNasc().toString());
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public String excluir(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "{CALL sp_cliente(?,?,?,?,?,?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		cs.setString(1, "D");
		cs.setString(2, c.getCpf());
		cs.setNull(3, Types.VARCHAR);
		cs.setNull(4, Types.VARCHAR);
		cs.setNull(5, Types.VARCHAR);
		cs.setNull(6, Types.VARCHAR);
		cs.registerOutParameter(7, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(7);
		cs.close();
		con.close();
		return saida;
	}

	@Override
	public Cliente buscar(Cliente c) throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();
		String sql = "SELECT cpf, nome, email, limite_de_credito, dt_nascimento FROM cliente WHERE cpf = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString (1,c.getCpf());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			c.setNome(rs.getString("nome"));
			c.setEmail(rs.getString("email"));
			c.setLimite(rs.getBigDecimal("limite_de_credito"));
			c.setDtNasc(LocalDate.parse(rs.getString("dt_nascimento")));
		}
		rs.close();
		ps.close();
		con.close();
		return c;
	}

	@Override
	public List<Cliente> listar() throws SQLException, ClassNotFoundException {
		List<Cliente> clientes = new ArrayList<>();
		Connection con = gDao.getConnection();
		String sql = "SELECT cpf, nome, email, limite_de_credito, dt_nascimento FROM cliente";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Cliente c = new Cliente();
			c.setCpf(rs.getString("cpf"));
			c.setNome(rs.getString("nome"));
			c.setEmail(rs.getString("email"));
			c.setLimite(rs.getBigDecimal("limite_de_credito"));
			c.setDtNasc(LocalDate.parse(rs.getString("dt_nascimento")));
			clientes.add(c);
		}
		rs.close();
		ps.close();
		con.close();
		return clientes;
	}
	
}
