<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.*"%>
<%@ page import="com.logiflow.model.Usuario"%>
<%@ page import="com.logiflow.model.Rol"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%
Usuario usuar = (Usuario) session.getAttribute("usuario");
String rolUsuar = (String) session.getAttribute("rolUsuario");
if (rolUsuar == null) rolUsuar = "USUARIO"; // Rol por defecto

// Leer el archivo JSON de permisos
String jsonPath = application.getRealPath("/permisos_sidebar.json");
StringBuilder jsonStr = new StringBuilder();
try (BufferedReader br = new BufferedReader(new FileReader(jsonPath))) {
    String line;
    while ((line = br.readLine()) != null) {
        jsonStr.append(line);
    }
} catch (Exception e) {
    out.println("<div style='color:red'>Error cargando permisos_sidebar.json: " + e.getMessage() + "</div>");
}
JSONObject permisos = null;
if (jsonStr.length() > 0) {
    permisos = new JSONObject(jsonStr.toString());
}
%>
<div class="sidebar">
	<style>
	.sidebar-heading {
		padding: 10px 25px 5px;
		font-size: 0.75rem;
		font-weight: 700;
		color: #858796;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.sidebar-heading:hover {
		cursor: pointer;
	}

	.sub-menu {
		display: none;
	}

	.sub-menu.active {
		display: flex;
		flex-direction: column;
	}

	.sub-menu .nav-item {
		padding-left: 40px;
	}

	.toggle-heading {
		cursor: pointer;
		background-color: #e3e6f0;
		padding: 10px 25px 5px;
		font-size: 0.75rem;
		font-weight: 700;
		color: #858796;
	}

	.toogle-heading:hover {
		background-color: #d1d3e2;
	}

	.sidebar {
		width: 250px;
		flex-shrink: 0;
		background: white;
		box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
		padding: 20px 0;
		min-height: calc(100vh - 80px);
		border-right: 1px solid #e3e6f0;
		overflow-y: auto;
	}

	.nav-section {
		margin-bottom: 20px;
		border-bottom: 1px solid #e3e6f0;
	}

	.nav-item {
		display: block;
		padding: 15px 25px;
		color: #333;
		text-decoration: none;
		font-weight: 500;
		border-left: 4px solid transparent;
		transition: all 0.3s ease;
		position: relative;
	}

	.nav-item:hover,
	.nav-item.active {
		background-color: #f8f9ff;
		border-left-color: #667eea;
		color: #667eea;
	}

	nav-item i {
		width: 20px;
		margin-right: 10px;
		text-align: center;
	}
	</style>
	<nav class="sidebar">
		<% if (permisos != null) {
            JSONArray menu = permisos.getJSONArray("menu");
            for (int i = 0; i < menu.length(); i++) {
                JSONObject item = menu.getJSONObject(i);
                // Si es un heading simple
                if (item.has("url")) {
                    JSONArray roles0 = item.getJSONArray("roles");
                    for (int r = 0; r < roles0.length(); r++) {
                        if (rolUsuar.equalsIgnoreCase(roles0.getString(r))) {
        %>
        <div class="nav-section">
            <a href="<%=request.getContextPath()%><%=item.getString("url")%>"
                class="nav-item <%=request.getRequestURI().contains(item.getString("url")) ? "active" : ""%>">
                <i class="<%=item.getString("icon")%>"></i> <%=item.getString("heading")%>
            </a>
        </div>
        <%      break; }
                    }
                } else if (item.has("subMenu")) {
                    JSONArray subMenu = item.getJSONArray("subMenu");
                    boolean showSection = false;
                    // Verificar si hay al menos un submenú visible
                    for (int j = 0; j < subMenu.length(); j++) {
                        JSONObject sub = subMenu.getJSONObject(j);
                        JSONArray roles1 = sub.getJSONArray("roles");
                        for (int r = 0; r < roles1.length(); r++) {
                            if (rolUsuar.equalsIgnoreCase(roles1.getString(r))) {
                                showSection = true;
                                break;
                            }
                        }
                        if (showSection) break;
                    }
                    if (showSection) {
        %>
        <div class="nav-section">
            <div class="sidebar-heading toggle-heading"><%=item.getString("heading")%></div>
            <div class="sub-menu">
                <% for (int j = 0; j < subMenu.length(); j++) {
                    JSONObject sub = subMenu.getJSONObject(j);
                    JSONArray rolesItem = sub.getJSONArray("roles");
                    boolean showSub = false;
                    for (int r = 0; r < rolesItem.length(); r++) {
                        if (rolUsuar.equalsIgnoreCase(rolesItem.getString(r))) {
                            showSub = true;
                            break;
                        }
                    }
                    if (showSub) {
                %>
                <a href="<%=request.getContextPath()%><%=sub.getString("url")%>"
                    class="nav-item <%=request.getRequestURI().contains(sub.getString("url")) ? "active" : ""%>">
                    <i class="<%=sub.getString("icon")%>"></i> <%=sub.getString("title")%>
                </a>
                <%  }
                } %>
            </div>
        </div>
        <%      }
                }
            }
        } %>
    </nav>
</div>
<script>
// Highlight del menú activo
document.addEventListener('DOMContentLoaded', function() {
    const currentPath = window.location.pathname;
    const navItems = document.querySelectorAll('.nav-item');
    
    navItems.forEach(item => {
        const href = item.getAttribute('href');
        if (href && currentPath.includes(href.split('/').pop())) {
            item.classList.add('active');
        }
    });
});
// Toggle para secciones colapsables
document.querySelectorAll('.toggle-heading').forEach(heading => {
    heading.addEventListener('click', () => {
        const subMenu = heading.nextElementSibling;
        subMenu.classList.toggle('active'); // activa/desactiva .sub-menu.active
    });
});

</script>