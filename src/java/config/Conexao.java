package config;

import java.sql.*;

public class Conexao {
    public Connection conectar() throws SQLException{
        try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           return DriverManager.getConnection("jdbc:mysql://localhost/gerenciadornotafiscal?user=root&passoword="); 
        }catch(ClassNotFoundException e){
            throw new RuntimeException(e);
        }
    }
}
