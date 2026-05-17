package com.movieticket.servlet;

import com.movieticket.dao.MovieDAO;
import com.movieticket.model.Movie;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();
    private static final String UPLOAD_DIR = "posters";

    @Override
    public void init() throws ServletException {
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list": listMovies(request, response); break;
                case "new": showAddForm(request, response); break;
                case "edit": showEditForm(request, response); break;
                case "delete": deleteMovie(request, response); break;
                case "detail": showDetail(request, response); break;
                default: listMovies(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Movie movie = new Movie();
            String action = null;
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");

                    switch (fieldName) {
                        case "action": action = value; break;
                        case "title": movie.setTitle(value); break;
                        case "genre": movie.setGenre(value); break;
                        case "duration":
                            if (!value.isEmpty())
                                movie.setDuration(Integer.parseInt(value));
                            break;
                        case "language": movie.setLanguage(value); break;
                        case "releaseDate":
                            if (!value.isEmpty())
                                movie.setReleaseDate(Date.valueOf(value));
                            break;
                        case "description": movie.setDescription(value); break;
                        case "posterUrl": movie.setPosterUrl(value); break;
                        case "trailerUrl": movie.setTrailerUrl(value); break;
                        case "status": movie.setStatus(value); break;
                        case "id":
                            if (!value.isEmpty())
                                movie.setId(Integer.parseInt(value));
                            break;
                    }
                } else {
                    if (item.getName() != null && !item.getName().isEmpty() && item.getSize() > 0) {
                        String fileName = System.currentTimeMillis() + "_" + item.getName();
                        File file = new File(uploadPath + File.separator + fileName);
                        item.write(file);
                        movie.setPosterPath(UPLOAD_DIR + "/" + fileName);
                    }
                }
            }

            if ("add".equals(action)) {
                movieDAO.addMovie(movie);
                response.sendRedirect(request.getContextPath() + "/movies?action=list");
            } else if ("update".equals(action)) {
                movieDAO.updateMovie(movie);
                response.sendRedirect(request.getContextPath() + "/movies?action=list");
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listMovies(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String keyword = request.getParameter("search");
        List<Movie> movies;
        if (keyword != null && !keyword.isEmpty()) {
            movies = movieDAO.searchMovies(keyword);
        } else {
            movies = movieDAO.getAllMovies();
        }
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/views/movie-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.getRequestDispatcher("/views/movie-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie movie = movieDAO.getMovieById(id);
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/views/movie-form.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie movie = movieDAO.getMovieById(id);
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/views/movie-detail.jsp").forward(request, response);
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        movieDAO.deleteMovie(id);
        response.sendRedirect(request.getContextPath() + "/movies?action=list");
    }
}