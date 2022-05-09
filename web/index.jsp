
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="config.Conexao"%>
<%@page import="com.mysql.jdbc.Driver"%>

<!DOCTYPE html>
<html>
    <head>
        <link href="css/style.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gerenciador de Notas Fiscais</title>
    </head>


    <body>
        <% Connection con = null;
            Statement st = null;
            ResultSet rs = null;
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand">Gerenciador de Nota Fiscal</a>  
            </div>
        </nav>

        <div class="container"> 
            <div class="form-row  mt-4 mb-4">
                <a type="button" class="btn btn-primary btn-sm  ml-1" href="index.jsp?funcao=novo">Cadastrar Cliente</a>
                <form class="form-inline my-1 my-lg-0 direita"method="post">
                    <input class="form-control form-control-sm mr-sm-2" type="search" name="txtbuscar" placeholder="Pesquisar Cliente" aria-label="Pesquisar">
                    <button class="btn btn-outline-info btn-sm my-2 my-sm-0 d-none d-md-block" type="submit" name="btn-pesquisar">Pesquisar</button>
                </form>
            </div>
            <table class="table table-sm table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Razão Social</th>
                        <th scope="col">CNPJ</th>
                        <th scope="col">Regime Tributário</th>
                        <th scope="col">E-mail</th>
                        <th scope="col">Ações</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        try {

                            Class.forName("com.mysql.cj.jdbc.Driver");

                            con = DriverManager.getConnection("jdbc:mysql://localhost/gerenciadornotafiscal?userTimezone=true&serveTimezone=UTC&user=root&password=");
                            st = con.createStatement();

                            st = new Conexao().conectar().createStatement();
                            if (request.getParameter("btn-pesquisar") != null) {
                                String busca = '%' + request.getParameter("txtbuscar") + '%';
                                rs = st.executeQuery("SELECT * FROM clientes where razaoSocial LIKE '" + busca + "' order by razaoSocial asc");
                                rs = st.executeQuery("SELECT * FROM clientes where regimeTributario LIKE '" + busca + "' order by razaoSocial asc");
                            } else {
                                rs = st.executeQuery("SELECT * FROM clientes order by razaoSocial asc");
                            }
                            while (rs.next()) {

                    %>
                    <tr>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                        <td><%= rs.getString(4)%></td>
                        <td><%= rs.getString(5)%></td>
                        <td>
                            <a name="" href="index.jsp?funcao=editar&id=<%= rs.getString(1)%>" type="button" class="btn btn-secondary btn-sm">Editar</a>
                            <a name=""  href="index.jsp?funcao=excluir&id=<%= rs.getString(1)%>" type="button" " class="btn btn-danger btn-sm">Excluir</a>

                        </td>
                    </tr>

                    <%
                            }

                        } catch (Exception e) {
                            out.println(e);
                        }


                    %>
                </tbody>
            </table>


        </div>


        <footer class="footer mt-autor py-3 bg-light">
            <div class="conteiner"></div>
        </footer>


    </body>
</html>

<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <%                    
                    String titulo = "";
                    String btn = "";
                    String xid = "";
                    String xrazaoSocial = "";
                    String xcnpj = "";
                    String xemail = "";
                    String xtipoRegimeTributario = "";
                    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
                        titulo = "Editar Usuário";
                        btn = "btn-editar";
                        xid = request.getParameter("id");
                        try {

                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM clientes where id = '" + xid + "'");
                            while (rs.next()) {
                                xrazaoSocial = rs.getString(2);
                                xcnpj = rs.getString(3);
                                xtipoRegimeTributario = rs.getString(4);
                                xemail = rs.getString(5);
                            }
                        } catch (Exception e) {
                        }

                    } else {
                        titulo = "Inserir Usuário";
                        btn = "btn-salvar";
                    }
                %>
                <h5 class="modal-title" id="hmodal"><%=titulo%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="cadastro-form" class="form" action="" method="post">
                <div class="modal-body">
                    
                    <input value="<%=xemail%>" type="hidden" name="txtantigo" id="txtantigo">

                    <div class="form-group">
                        <label for="razSocial" class="text">Razão Social</label><br>
                        <input value="<%=xrazaoSocial%>" type="text" name="razSocial" id="razSocial" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="incnpj" class="text">CNPJ</label><br>
                        <input value="<%=xcnpj%>" type="text" name="incnpj" id="incnpj" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="tipodeRegimeTributario">Regime Tributário</label>
                        <select class="form-control" name="tipodeRegimeTributario" id="tipodeRegimeTributario">
                            <option value="<%=xtipoRegimeTributario%>"><%=xtipoRegimeTributario%></option>
                            <%if(!xtipoRegimeTributario.equals("Simples Nacional")){
                                out.print("<option>Simples Nacional</option>");
                            }
                            if(!xtipoRegimeTributario.equals("Lucro Presumido")){
                                out.print("<option>Lucro Presumido</option>");
                            }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="inemail" class="text">E-mail</label><br>
                        <input value="<%=xemail%>" type="email" name="inemail" id="inemail" class="form-control">
                    </div>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    <button type="submit" name="<%=btn %>" class="btn btn-primary"><%=titulo%></button>
                </div>

            </form>

        </div>
    </div>
</div>

<%    if (request.getParameter("btn-salvar") != null) {
        String razaoSocial = request.getParameter("razSocial");
        String cnpj = request.getParameter("incnpj");
        String email = request.getParameter("inemail");
        String tipoRegimeTributario = request.getParameter("tipodeRegimeTributario");

        try {
            st = new Conexao().conectar().createStatement();

            rs = st.executeQuery("SELECT * FROM clientes where email = '" + email + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("<script>alert('Usuario Já Cadastrado!');</script>");
                    return;
                }
            }

            st.executeUpdate("INSERT into clientes (razaoSocial, cnpj, regimeTributario, email) values('" + razaoSocial + "', '" + cnpj + "', '" + tipoRegimeTributario + "', '" + email + "')");
            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            out.print(e);
        }

    }
%>
<%    if (request.getParameter("btn-editar") != null) {
        String razaoSocial = request.getParameter("razSocial");
        String cnpj = request.getParameter("incnpj");
        String email = request.getParameter("inemail");
        String tipoRegimeTributario = request.getParameter("tipodeRegimeTributario");
        String id = request.getParameter("id");
        String antigo = request.getParameter("txtantigo");

        try {
            st = new Conexao().conectar().createStatement();
            if(!antigo.equals(email)){

            rs = st.executeQuery("SELECT * FROM clientes where email = '" + email + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("<script>alert('Usuario Já Cadastrado!');</script>");
                    return;
                }
            }
            }
            st.executeUpdate("UPDATE clientes SET razaoSocial = '" + razaoSocial + "', cnpj = '" + cnpj + "', regimeTributario = '" + tipoRegimeTributario + "', email = '" + email + "' WHERE id = '" + id + "'");
            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            out.print(e);
        }
        
    }
%>

<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {
        String id = request.getParameter("id");
        try {
            st = new Conexao().conectar().createStatement();
            st.executeUpdate("DELETE FROM clientes WHERE `id` = '" + id + "'");
            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            out.print(e);
        }
    }
%>

<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
        out.print("<script>$('#modal').modal('show');</script>");
    }
%>
<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.print("<script>$('#modal').modal('show');</script>");
    }
%>
