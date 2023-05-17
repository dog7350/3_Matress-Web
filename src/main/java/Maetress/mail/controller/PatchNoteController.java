package Maetress.mail.controller;

import Maetress.entity.*;
import Maetress.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.List;

@Controller
public class PatchNoteController {
    @Autowired
    UserRepository userRepository;

    @Autowired
    PatchNoteRepository patchNoteRepository;

    @GetMapping("/PNpage")
    public String PNpage(HttpServletRequest request) {
        if(userRepository.rnField() != null) if(userRepository.rnField().equals("rn")) userRepository.rnDrop();

        List<PatchNote> patchNotes = patchNoteRepository.notesAll();
        request.setAttribute("patchNotes", patchNotes);

        if(request.getParameter("P_State") != null && request.getParameter("P_State").equals("modify")) {
            int p_no = Integer.parseInt(request.getParameter("p_no"));
            String P_State = request.getParameter("P_State");
            PatchNote modNote = patchNoteRepository.findOnenote(p_no);

            request.setAttribute("P_State", P_State);
            request.setAttribute("modNote", modNote);
        }

        return "patchnote";
    }

    @PostMapping("/noteinsert")
    public String noteinsert(HttpServletRequest request) {
        String noteTitle = request.getParameter("noteTitle");
        String noteContent = request.getParameter("noteContent");
        patchNoteRepository.noteInsert(noteTitle, noteContent);

        return "redirect:/PNpage";
    }

    @GetMapping("/notemodifymove")
    public String notemodifymove(HttpServletRequest request) {
        int p_no = Integer.parseInt(request.getParameter("p_no"));

        String P_State = request.getParameter("P_State");

        return "redirect:/PNpage?p_no=" + p_no + "&P_State=" + P_State;
    }

    @PostMapping("/notemodify")
    public String notemodify(HttpServletRequest request) {
        int p_no = Integer.parseInt(request.getParameter("p_no"));
        Timestamp time = Timestamp.valueOf(request.getParameter("ti"));
        String noteTitle = request.getParameter("noteTitle");
        String noteContent = request.getParameter("noteContent");

        patchNoteRepository.noteUpdate(noteTitle, noteContent, time, p_no);

        return "redirect:/PNpage";
    }

    @GetMapping("/deletenote")
    public String deletenote(HttpServletRequest request) {
        int p_no = Integer.parseInt(request.getParameter("p_no"));
        patchNoteRepository.noteDelete(p_no);

        return "redirect:/PNpage";
    }
}
