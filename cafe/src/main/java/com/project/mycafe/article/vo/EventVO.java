package com.project.mycafe.article.vo;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

@Component("eventVO")
public class EventVO {
	private int eventId;
	private String eventName;
	private String eventDescription;
	private String eventPlace;
	private String eventRegion;
	private String eventStatus;
	private String eventSite;
	private Date eventStartDate;
	private Date eventEndDate;
	private Date eventRegiDate;
	private String eventImage;

	private String formattedStartDate;
	private String formattedEndDate;
	private List<String> imageList;

	public EventVO() {
		super();
	}

	public EventVO(int eventId, String eventName, String eventDescription, String eventPlace, String eventRegion,
			String eventStatus, String eventSite, Date eventStartDate, Date eventEndDate, Date eventRegiDate,
			String eventImage, String formattedStartDate, String formattedEndDate, List<String> imageList) {
		super();
		this.eventId = eventId;
		this.eventName = eventName;
		this.eventDescription = eventDescription;
		this.eventPlace = eventPlace;
		this.eventRegion = eventRegion;
		this.eventStatus = eventStatus;
		this.eventSite = eventSite;
		this.eventStartDate = eventStartDate;
		this.eventEndDate = eventEndDate;
		this.eventRegiDate = eventRegiDate;
		this.eventImage = eventImage;
		this.formattedStartDate = formattedStartDate;
		this.formattedEndDate = formattedEndDate;
		this.imageList = imageList;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public String getEventDescription() {
		return eventDescription;
	}

	public void setEventDescription(String eventDescription) {
		this.eventDescription = eventDescription;
	}

	public String getEventPlace() {
		return eventPlace;
	}

	public void setEventPlace(String eventPlace) {
		this.eventPlace = eventPlace;
	}

	public String getEventRegion() {
		return eventRegion;
	}

	public void setEventRegion(String eventRegion) {
		this.eventRegion = eventRegion;
	}

	public String getEventStatus() {
		return eventStatus;
	}

	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}

	public String getEventSite() {
		return eventSite;
	}

	public void setEventSite(String eventSite) {
		this.eventSite = eventSite;
	}

	public Date getEventStartDate() {
		return eventStartDate;
	}

	public void setEventStartDate(Date eventStartDate) {
		this.eventStartDate = eventStartDate;
	}

	public Date getEventEndDate() {
		return eventEndDate;
	}

	public void setEventEndDate(Date eventEndDate) {
		this.eventEndDate = eventEndDate;
	}

	public Date getEventRegiDate() {
		return eventRegiDate;
	}

	public void setEventRegiDate(Date eventRegiDate) {
		this.eventRegiDate = eventRegiDate;
	}

	public String getEventImage() {
		return eventImage;
	}

	public void setEventImage(String eventImage) {
		this.eventImage = eventImage;
	}

	public String getFormattedStartDate() {
		return formattedStartDate;
	}

	public void setFormattedStartDate(String formattedStartDate) {
		this.formattedStartDate = formattedStartDate;
	}

	public String getFormattedEndDate() {
		return formattedEndDate;
	}

	public void setFormattedEndDate(String formattedEndDate) {
		this.formattedEndDate = formattedEndDate;
	}

	public List<String> getImageList() {
		return imageList;
	}

	public void setImageList(List<String> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "EventVO [eventId=" + eventId + ", eventName=" + eventName + ", eventDescription=" + eventDescription
				+ ", eventPlace=" + eventPlace + ", eventRegion=" + eventRegion + ", eventStatus=" + eventStatus
				+ ", eventSite=" + eventSite + ", eventStartDate=" + eventStartDate + ", eventEndDate=" + eventEndDate
				+ ", eventRegiDate=" + eventRegiDate + ", eventImage=" + eventImage + ", formattedStartDate="
				+ formattedStartDate + ", formattedEndDate=" + formattedEndDate + ", imageList=" + imageList + "]";
	}

}
