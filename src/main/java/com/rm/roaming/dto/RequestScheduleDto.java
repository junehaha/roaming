package com.rm.roaming.dto;

import java.util.List;

public class RequestScheduleDto {
    private List<DayScheduleDto> days;
     public RequestScheduleDto() {
	}
    public RequestScheduleDto(List<DayScheduleDto> days) {
		super();
		this.days = days;
	}
    

    public List<DayScheduleDto> getDays() {
		return days;
	}
	public void setDays(List<DayScheduleDto> days) {
		this.days = days;
	}
	
	@Override
	public String toString() {
		return "RequestScheduleDto [days=" + days + "]";
	}

	public static class DayScheduleDto {
        private int day;
        private List<ScheduleDto> schedule;
        public DayScheduleDto() {
		}
		public DayScheduleDto(int day, List<ScheduleDto> schedule) {
			super();
			this.day = day;
			this.schedule = schedule;
		}
		public int getDay() {
			return day;
		}
		public void setDay(int day) {
			this.day = day;
		}
		public List<ScheduleDto> getSchedule() {
			return schedule;
		}
		public void setSchedule(List<ScheduleDto> schedule) {
			this.schedule = schedule;
		}
		@Override
		public String toString() {
			return "DayScheduleDto [day=" + day + ", schedule=" + schedule + "]";
		}
        
        
    }

    public static class ScheduleDto {
    	private int id;
    	private int day_id;
    	private int index;
        private String name;
        private String address;
        private String timeInput;
        private String memoInput;
         public ScheduleDto() {
		}
		public ScheduleDto(int id, int day_id, int index, String name, String address, String timeInput,
				String memoInput) {
			super();
			this.id = id;
			this.day_id = day_id;
			this.index = index;
			this.name = name;
			this.address = address;
			this.timeInput = timeInput;
			this.memoInput = memoInput;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public int getDay_id() {
			return day_id;
		}
		public void setDay_id(int day_id) {
			this.day_id = day_id;
		}
		public int getIndex() {
			return index;
		}
		public void setIndex(int index) {
			this.index = index;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getTimeInput() {
			return timeInput;
		}
		public void setTimeInput(String timeInput) {
			this.timeInput = timeInput;
		}
		public String getMemoInput() {
			return memoInput;
		}
		public void setMemoInput(String memoInput) {
			this.memoInput = memoInput;
		}
		@Override
		public String toString() {
			return "ScheduleDto [id=" + id + ", day_id=" + day_id + ", index=" + index + ", name=" + name + ", address="
					+ address + ", timeInput=" + timeInput + ", memoInput=" + memoInput + "]";
		}
		         
    }
}

		

