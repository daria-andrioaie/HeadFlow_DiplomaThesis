const express = require("express");

const therapistController = require("../controller/therapist.controller");

const router = express.Router();

router.get("/allCollaborations", therapistController.allCollaborations);
router.post("/sendInvitation", therapistController.sendInvitation);
router.post("/searchPatient", therapistController.searchPatient);
router.post("/allSessions", therapistController.getPatientSessionsHistory);
router.post("/plannedSession", therapistController.getPlannedStretchingSessionOfPatient);
router.post("/saveSession", therapistController.savePlannedSessionForPatient);

module.exports = router;