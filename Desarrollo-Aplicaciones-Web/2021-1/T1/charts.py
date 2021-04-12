import matplotlib.pyplot as plt
from matplotlib.dates import date2num
import numpy as np
import datetime

# GRAFICO 1
""" grafico1_x = ["2020-10-11","2020-12-25","2021-01-16","2021-02-02","2021-02-27","2021-03-29"]
grafico1_y = [2,1,1,1,1,1]
fig1, plt1 = plt.subplots()
plt1.plot(grafico1_x,grafico1_y)
plt1.grid()
plt1.set_title('Número de avistamientos por día')
plt1.set_xlabel('Fecha')
plt1.set_ylabel('Avistamientos') """

# GRAFICO 2
""" grafico2_labels = 'Insecto', 'Arácnido', 'Miriápodo'
grafico2_sizes = numpy.array([3, 2, 2])
def absolute_value(val):
    a  = numpy.round(val/100.*grafico2_sizes.sum(), 0)
    return a
fig2, plt2 = plt.subplots()
plt2.pie(grafico2_sizes, labels=grafico2_labels,  autopct=absolute_value,
        shadow=True, startangle=90)
plt2.axis('equal')
plt2.set_title('Número de avistamientos por tipo') """

# GRAFICO 3
data = np.array([[40, 20, 10], [50, 10, 10], [30, 10, 15], [60,25,30], [40, 45, 12], [60, 35, 15], [71, 24, 11], [40, 20, 10], [50, 10, 10], [30, 10, 15], [60,25,30], [40, 45, 12]])
data_std = np.array([[1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1], [1, 2, 1]])

length = len(data)
x_labels = ['enero', 'febrero', 'marzo', 'abril', 
    'mayo', 'junio', 'julio', 'agosto', 'septiembre',
    'octubre','noviembre','diciembre']

# Set plot parameters
fig, ax = plt.subplots()
width = 0.2 # width of bar
x = np.arange(length)

ax.bar(x, data[:,0], width, color='#000080', label='Vivo', yerr=data_std[:,0])
ax.bar(x + width, data[:,1], width, color='#0F52BA', label='Muerto', yerr=data_std[:,1])
ax.bar(x + (2 * width), data[:,2], width, color='#6593F5', label='No sabe', yerr=data_std[:,2])

ax.set_ylabel('Estado')
ax.set_ylim(0,75)
ax.set_xticks(x + width + width/2)
ax.set_xticklabels(x_labels)
ax.set_xlabel('Día')
ax.set_title('Estado de avistamiento por día')
ax.legend()
plt.grid(True, 'major', 'y', ls='--', lw=.5, c='k', alpha=.3)

fig.tight_layout()
plt.xticks(rotation = 45)
plt.show()