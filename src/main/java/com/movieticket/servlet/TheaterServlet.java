package com.movieticket.servlet;

import com.movieticket.dao.MovieDAO;
import com.movieticket.dao.TheaterDAO;
import com.movieticket.model.Screen;
import com.movieticket.model.Show;
import com.movieticket.model.Theater;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/theater")
public class TheaterServlet extends HttpServlet {

    private TheaterDAO theaterDAO = new TheaterDAO();
    private MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list": listTheaters(request, response); break;
                case "addTheater": showAddTheaterForm(request, response); break;
                case "editTheater": showEditTheaterForm(request, response); break;
                case "deleteTheater": deleteTheater(request, response); break;
                case "screens": listScreens(request, response); break;
                case "addScreen": showAddScreenForm(request, response); break;
                case "editScreen": showEditScreenForm(request, response); break;
                case "deleteScreen": deleteScreen(request, response); break;
                case "shows": listShows(request, response); break;
                case "addShow": showAddShowForm(request, response); break;
                case "editShow": showEditShowForm(request, response); break;
                case "deleteShow": deleteShow(request, response); break;
                default: listTheaters(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "saveTheater": saveTheater(request, response); break;
                case "saveScreen": saveScreen(request, response); break;
                case "saveShow": saveShow(request, response); break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // ==================== THEATER ACTIONS ====================

    private void listTheaters(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Theater> theaters = theaterDAO.getAllTheaters();
        request.setAttribute("theaters", theaters);
        request.getRequestDispatcher("/views/theater/theater-list.jsp").forward(request, response);
    }

    private void showAddTheaterForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.getRequestDispatcher("/views/theater/theater-form.jsp").forward(request, response);
    }

    private void showEditTheaterForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Theater theater = theaterDAO.getTheaterById(id);
        request.setAttribute("theater", theater);
        request.getRequestDispatcher("/views/theater/theater-form.jsp").forward(request, response);
    }

    private void saveTheater(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Theater theater = new Theater();
        theater.setName(request.getParameter("name"));
        theater.setLocation(request.getParameter("location"));
        String totalScreens = request.getParameter("totalScreens");
        theater.setTotalScreens(totalScreens != null && !totalScreens.isEmpty() ?
            Integer.parseInt(totalScreens) : 0);

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            theater.setId(Integer.parseInt(idParam));
            theaterDAO.updateTheater(theater);
        } else {
            theaterDAO.addTheater(theater);
        }
        response.sendRedirect(request.getContextPath() + "/theater?action=list");
    }

    private void deleteTheater(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        theaterDAO.deleteTheater(id);
        response.sendRedirect(request.getContextPath() + "/theater?action=list");
    }

    // ==================== SCREEN ACTIONS ====================

    private void listScreens(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Screen> screens = theaterDAO.getAllScreens();
        List<Theater> theaters = theaterDAO.getAllTheaters();
        request.setAttribute("screens", screens);
        request.setAttribute("theaters", theaters);
        request.getRequestDispatcher("/views/theater/screen-list.jsp").forward(request, response);
    }

    private void showAddScreenForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Theater> theaters = theaterDAO.getAllTheaters();
        request.setAttribute("theaters", theaters);
        request.getRequestDispatcher("/views/theater/screen-form.jsp").forward(request, response);
    }

    private void showEditScreenForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Screen screen = theaterDAO.getScreenById(id);
        List<Theater> theaters = theaterDAO.getAllTheaters();
        request.setAttribute("screen", screen);
        request.setAttribute("theaters", theaters);
        request.getRequestDispatcher("/views/theater/screen-form.jsp").forward(request, response);
    }

    private void saveScreen(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Screen screen = new Screen();
        screen.setTheaterId(Integer.parseInt(request.getParameter("theaterId")));
        screen.setScreenName(request.getParameter("screenName"));
        String totalSeats = request.getParameter("totalSeats");
        screen.setTotalSeats(totalSeats != null && !totalSeats.isEmpty() ?
            Integer.parseInt(totalSeats) : 0);

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            screen.setId(Integer.parseInt(idParam));
            theaterDAO.updateScreen(screen);
        } else {
            theaterDAO.addScreen(screen);
        }
        response.sendRedirect(request.getContextPath() + "/theater?action=screens");
    }

    private void deleteScreen(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        theaterDAO.deleteScreen(id);
        response.sendRedirect(request.getContextPath() + "/theater?action=screens");
    }

    // ==================== SHOW ACTIONS ====================

    private void listShows(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Show> shows = theaterDAO.getAllShows();
        request.setAttribute("shows", shows);
        request.getRequestDispatcher("/views/theater/show-list.jsp").forward(request, response);
    }

    private void showAddShowForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Screen> screens = theaterDAO.getAllScreens();
        request.setAttribute("movies", movieDAO.getAllMovies());
        request.setAttribute("screens", screens);
        request.getRequestDispatcher("/views/theater/show-form.jsp").forward(request, response);
    }

    private void showEditShowForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Show show = theaterDAO.getShowById(id);
        request.setAttribute("show", show);
        request.setAttribute("movies", movieDAO.getAllMovies());
        request.setAttribute("screens", theaterDAO.getAllScreens());
        request.getRequestDispatcher("/views/theater/show-form.jsp").forward(request, response);
    }

    private void saveShow(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Show show = new Show();
        show.setMovieId(Integer.parseInt(request.getParameter("movieId")));
        show.setScreenId(Integer.parseInt(request.getParameter("screenId")));
        show.setShowDate(request.getParameter("showDate"));
        show.setShowTime(request.getParameter("showTime"));
        show.setPrice(Double.parseDouble(request.getParameter("price")));

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            show.setId(Integer.parseInt(idParam));
            theaterDAO.updateShow(show);
        } else {
            theaterDAO.addShow(show);
        }
        response.sendRedirect(request.getContextPath() + "/theater?action=shows");
    }

    private void deleteShow(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        theaterDAO.deleteShow(id);
        response.sendRedirect(request.getContextPath() + "/theater?action=shows");
    }
}